
//  Created by Евгений Никитин on 02.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit
import RealmSwift

// Создаем абстракцию, в которой идет перечисление всех видимых функций
protocol GroupsPresenter {
    func viewDidLoad(tableView: UITableView)
    func numberOfRowsInSection(section: Int) -> Int
    func searchGroups(name: String)
    func removeFromSwipe(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle)
    func getModelAtIndex(indexPath: IndexPath) -> GroupsRealm?
    func cellRegistration(tableView: UITableView)
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}

class GroupsPresenterImplementation: GroupsPresenter {
    private var vkAPI: VKApi
    private var database: GroupsSource
    private var groupsResult: Results<GroupsRealm>? 
    private var token: NotificationToken?
    private weak var view: GroupsTableUpdater? 
    
    init(database: GroupsSource, view: GroupsTableUpdater) {
        vkAPI = VKApi()
        self.database = database
        self.view = view
    }
    
    func viewDidLoad(tableView: UITableView) {
        getGroupsFromDatabase()
        getGroupsFromApi()
        cellRegistration(tableView: tableView)
    }
    
    deinit {
        token?.invalidate()
    }
    
    // Поиск по группам
    func searchGroups(name: String) {
        do {
            self.groupsResult = name.isEmpty ?
                try database.getAllGroups() :
                try database.searchGroups(name: name.lowercased())
        } catch {
            print("\(ApplicationErrors.searchGroupsError): \(error)")
        }
        self.view?.updateTable()
    }
    
    // Удаление группы по свайпу влево
    func removeFromSwipe(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle) {
        if editingStyle == .delete {
            self.database.deleteGroup(id: getModelAtIndex(indexPath: indexPath)?.id ?? 0)
            self.view?.deleteRows(indexPath: [indexPath])
        }
    }
    
    // Группы из репозитория
    func getGroupsFromDatabase() {
        do {
            groupsResult = try database.getAllGroups()
            self.view?.updateTable()
        } catch {
            print(error)
        }
    }
    
    // API-request (Работа с апи-запросом обернута в Promise Kit)
    func getGroupsFromApi() {
        vkAPI.getGroups(token: UserSession.defaultSession.token, userID: UserSession.defaultSession.id)
        .done { groups in
            self.database.addGroups(groups: groups)
            self.getGroupsFromDatabase()
        } .catch { error in
            print("\(ApplicationErrors.getGroupsFromApiError): \(error)")
        }
    }
}


// MARK: Кастомизация таблицы
extension GroupsPresenterImplementation {
    /// Количество ячеек в секции
    func numberOfRowsInSection(section: Int) -> Int {
        return groupsResult?.count ?? 0
    }
    /// Регистрируем прототип
    func cellRegistration(tableView: UITableView) {
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
    } 
    /// Получаем модель
    func getModelAtIndex(indexPath: IndexPath) -> GroupsRealm? {
        return groupsResult?[indexPath.row]
    }
    /// Кастомизация
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell,
            let model =  getModelAtIndex(indexPath: indexPath) else {
                return UITableViewCell()
        }
        cell.groupname.text = model.name
        cell.groupKind.text = model.type
        if let url = URL(string: model.photo) {
            cell.avatar.kf.setImage(with: url)
        }
        return cell
    }
}
