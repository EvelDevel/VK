
//  Created by Евгений Никитин on 11.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

protocol SearchGroupPresenter {
    func viewDidLoad(tableView: UITableView)
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func textDidChange(searchText: String, tableView: UITableView)
}

class SearchGroupPresenterImplementation: SearchGroupPresenter {
    var globalGroups = GlobalGroupsDatabase.getGlobalGroups()
    
    func viewDidLoad(tableView: UITableView) {
        cellRegistration(tableView: tableView)
    }
}


// MARK: Сборка таблицы
extension SearchGroupPresenterImplementation {
    /// Регистрация прототипа
    func cellRegistration(tableView: UITableView) {
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
    }
    /// Количество ячеек
    func numberOfRowsInSection(section: Int) -> Int {
        return globalGroups.count
    }
    /// Кастомизация
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        let model = globalGroups[indexPath.row]
        cell.groupname.text = model.groupName
        cell.avatar.image = UIImage(named: model.avatarPath)
        cell.groupKind.text = model.kind
        return cell
    }
}


// MARK: Расширение для подключения Search Bar
extension SearchGroupPresenterImplementation {
    func textDidChange(searchText: String, tableView: UITableView) {
        globalGroups = GlobalGroupsDatabase.getGlobalGroups().filter { (group) -> Bool in
            return searchText.isEmpty ? true : group.groupName.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

