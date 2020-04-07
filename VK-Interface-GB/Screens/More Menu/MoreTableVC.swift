
//  Created by Евгений Никитин on 30.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

// Протокол обновления данных в таблице
protocol MoreTableUpdater: class {
    func updateTable()
}

class MoreTableVC: UITableViewController {

    var presenter: MorePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MorePresenterImplementation(view: self)
        presenter?.viewDidLoad(tableView: tableView)
    }
    
    // Убираем header (делает высоту отступа слишком большой)
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    

    // MARK: Конфигурация и настройка таблицы
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections(tableView: tableView) ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.heightForRowAt(indexPath: indexPath) ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.cellForRowAt(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
    /// Отработка нажатий и переходов
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath, navigationController: navigationController!, tableView: tableView)
    }
}


// MARK: Обновление таблицы
extension MoreTableVC: MoreTableUpdater {
    func updateTable() {
        tableView.reloadData()
    }
}

