
//  Created by Евгений Никитин on 11.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class MessageTableVC: UITableViewController {
    
    var presenter: MessagePresenter?
    
    override func viewDidLoad() {
        presenter = MessagePresenterImplementation()
        presenter?.viewDidLoad()
        cellCustomization()
    }
    
    
    // MARK: Конфигурация и настройка таблицы
    func cellCustomization() {
        presenter?.cellCustomization(tableView: tableView)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.cellForRowAt(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
}
