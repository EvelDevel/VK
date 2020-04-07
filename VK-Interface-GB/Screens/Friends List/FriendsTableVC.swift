
//  Created by Евгений Никитин on 01.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

struct Section<T> {
    var title: String
    var items: [T]
}

protocol FriendsTableUpdater: class {
    func updateTable()
}

class FriendsTableVC: UITableViewController {
    
    var presenter: FriendsPresenter?
    var configurator: FriendsConfigurator?
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(view: self)
        presenter?.viewDidLoad()
        friendsSearchBar.delegate = self
        updateNavigationBar()
        cellRegistration(tableView: tableView)
    }
    
    
    // MARK: User Interface
    // Navigation Bar
    func updateNavigationBar() {
        let backButtonItem = UIBarButtonItem()  //Убираем надпись на кнопке возврата
        backButtonItem.title = ""
        backButtonItem.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
    }
    // Контрол поиска по алфавиту
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return presenter?.getSectionIndexTitles()
    }
    // Кастомные заголовки секций (Первая буква "ключа" нашего словаря)
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return presenter?.viewForHeaderInSection(section: section)
    }
    
    
    // MARK: Конфигурация и настройка таблицы
    func cellRegistration(tableView: UITableView) {
        presenter?.cellRegistration(tableView: tableView)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.cellCustomization(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath, navigationController: navigationController!)
    }
}


// MARK: Обновление таблицы
extension FriendsTableVC: FriendsTableUpdater {
    func updateTable() {
        tableView.reloadData()
    }
}


// MARK: Подключение search-bar
extension FriendsTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchFriends(name: searchText)
    }
    /// Когда нажимаем кнопку поиска - скрываем клавиатуру
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
