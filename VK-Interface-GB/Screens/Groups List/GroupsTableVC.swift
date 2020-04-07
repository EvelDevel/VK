
//  Created by Евгений Никитин on 02.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit
import Kingfisher
import RealmSwift

// Протокол обновления данных в таблице
protocol GroupsTableUpdater: class {
    func updateTable()
    func deleteRows(indexPath: [IndexPath])
}

class GroupsTableVC: UITableViewController {
    
    var presenter: GroupsPresenter?
    var configurator: GroupsConfigurator?
    var customRefreshControl = UIRefreshControl()       // Свойство для Pull-to-Refresh
    @IBOutlet weak var groupSearchBar: UISearchBar!     // Добавляем SearchBar (#1 - #7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(view: self)
        presenter?.viewDidLoad(tableView: tableView)
        groupSearchBar.delegate = self
        addRefreshControl()
        updateNavigationBar()
    }
    
    // Кастомизируем Navigation Bar
    func updateNavigationBar() {
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
    }
    
    // Удаление сообщества по свайпу ячейки влево
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter?.removeFromSwipe(indexPath: indexPath, editingStyle: editingStyle)
    }
    
    
    // MARK: Pull-to-Refresh (Обновление страницы)
    // Кастомизируем поведение
    func addRefreshControl() {
        customRefreshControl.attributedTitle = NSAttributedString(string: "Обновляем страницу")
        customRefreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.refreshControl = customRefreshControl
    }
    // Функция с заглушкой (чтобы обновление прекращалось через 2 секунды)
    @objc func refreshTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.customRefreshControl.endRefreshing()
        }
    }

    
    // MARK: Конфигурация и настройка таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.cellForRowAt(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
}


// MARK: Кастомизация таблицы
extension GroupsTableVC: GroupsTableUpdater {
    /// Простое обновление
    func updateTable() {
        tableView.reloadData()
    }
    /// Анимированное удаление одной ячейки
    func deleteRows(indexPath: [IndexPath]) {
        tableView.deleteRows(at: indexPath, with: .fade)
    }
}


// MARK: Подключения Search Bar
extension GroupsTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchGroups(name: searchText)
    }
    /// Скрываем клавиатуру после нажатия "search"
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { view.endEditing(true) }
}
