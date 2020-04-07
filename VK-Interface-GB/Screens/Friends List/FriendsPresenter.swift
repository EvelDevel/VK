
//  Created by Евгений Никитин on 29.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit
import RealmSwift

protocol FriendsPresenter {
    func viewDidLoad()
    func searchFriends(name: String)
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getSectionIndexTitles() -> [String]?
    func getTitleForSection(section: Int) -> String?
    func getModelAtIndex(indexPath: IndexPath) -> FriendsRealm?
    func cellRegistration(tableView: UITableView)
    func viewForHeaderInSection(section: Int) -> UIView
    func cellCustomization(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath, navigationController: UINavigationController)
}

class FriendsPresenterImplementation: FriendsPresenter {
    private var vkAPI: VKApi
    private var database: FriendsSource
    private var sortedFriendsResults = [Section<FriendsRealm>]()
    private var friendsResult: Results<FriendsRealm>!
    private weak var view: FriendsTableUpdater?
    
    init(database: FriendsSource, view: FriendsTableUpdater) {
        vkAPI = VKApi()
        self.database = database
        self.view = view
    }
    
    func viewDidLoad() {
        getFriendsFromDatabase()
        getFriendsFromApi()
    }
    
    // Database-request
    private func getFriendsFromDatabase() {
        do {
            // Получаем список всех друзей
            self.friendsResult = try database.getAllUsers()
            self.makeSortedSections()
            self.view?.updateTable()
        } catch {
            print(error) }
    }
    
    // API-request (Работа с апи-запросом обернута в Promise Kit)
    private func getFriendsFromApi() {
        vkAPI.getFriendList(token: UserSession.defaultSession.token, userID: UserSession.defaultSession.id)
        .done { users in
            self.database.addUsers(users: users)
            self.getFriendsFromDatabase()
        } .catch { error in
            print("\(ApplicationErrors.getFriendsFromApiError): \(error)") 
        }
    }
    
    // Поиск по пользователям
    func searchFriends(name: String) {
        do {
            self.friendsResult = name.isEmpty ?
                try database.getAllUsers() :
                try database.searchFriends(name: name)
            /// Функция поиска с фильтрацией по введенному в строку поиска тексту
            let groupedFriends = Dictionary(grouping: friendsResult) { $0.lastname.prefix(1) }
            /// Реализация группирования в секции
            sortedFriendsResults = groupedFriends.map { Section(title: String($0.key), items: $0.value) }
            sortedFriendsResults.sort { $0.title < $1.title }
            self.view?.updateTable()
        } catch {
            print(error)
        }
    }
    
    // Группировка в секции (сортировка по фамилии)
    private func makeSortedSections() {
        let groupedFriends = Dictionary.init(grouping: self.friendsResult) { $0.lastname.prefix(1) }
        self.sortedFriendsResults = groupedFriends.map { Section(title: String($0.key), items: $0.value) }
        self.sortedFriendsResults.sort { $0.title < $1.title }
    }
}


// MARK: Кастомизация таблицы
extension FriendsPresenterImplementation {
    /// Количество секций
    func numberOfSections() -> Int {
        return sortedFriendsResults.count
    }
    /// Количество ячеек в секции
    func numberOfRowsInSection(section: Int) -> Int {
        return sortedFriendsResults[section].items.count
    }
    /// Сама модель ячейки
    func getModelAtIndex(indexPath: IndexPath) -> FriendsRealm? {
        return sortedFriendsResults[indexPath.section].items[indexPath.row]
    }
    /// Устанавливаем заголовки
    func getSectionIndexTitles() -> [String]? {
        return sortedFriendsResults.map { $0.title }
    }
    /// Разобраться что за заголовок (в пылу сражения не понял)
    func getTitleForSection(section: Int) -> String? {
        return sortedFriendsResults[section].title
    }
    /// Регистрация прототипа
    func cellRegistration(tableView: UITableView) {
        tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
    }
    /// Кастомные заголовки секций (Первая буква "ключа" нашего словаря)
    func viewForHeaderInSection(section: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.text = getTitleForSection(section: section) ?? ""
        label.frame = CGRect(x: 10, y: 15, width: 14, height: 15)
        label.textColor = UIColor.darkGray
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        return view
    }
    /// Кастомизация ячейки
    func cellCustomization(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell,
            let friendModel = getModelAtIndex(indexPath: indexPath) else {
                return UITableViewCell()
        }
        /// Выводим имя и фамилию
        let username = friendModel.name
        let surname = friendModel.lastname
        cell.username.text = username + " " + surname
        
        /// Выводим аватарку пользователя
        if let url = URL(string: friendModel.photo) {
            cell.avatar.kf.setImage(with: url)
        }
        return cell
    }
}


// MARK: Отработка переходов по нажатию на ячейку
extension FriendsPresenterImplementation {
    func didSelectRowAt(indexPath: IndexPath, navigationController: UINavigationController) {
        let storyboard = UIStoryboard(name: "More", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotosViewController") as! PhotosCollectionVC
        let username = getModelAtIndex(indexPath: indexPath)?.name ?? "Username"
        let lastname = getModelAtIndex(indexPath: indexPath)?.lastname ?? "Lastname"
        viewController.configurator = PhotosConfiguratorImplementation()
        viewController.user = username + " " + lastname
        viewController.userID = String(getModelAtIndex(indexPath: indexPath)?.id ?? 0)
        navigationController.pushViewController(viewController, animated: true)
    }
}
