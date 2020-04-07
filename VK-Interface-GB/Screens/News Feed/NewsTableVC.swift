
//  Created by Евгений Никитин on 12.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit
import Kingfisher

// Протокол обновления данных в таблице
protocol NewsTableUpdater: class {
    func updateTable()
}

class NewsTableVC: UITableViewController {
    
    var presenter: NewsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewsPresenterImplementation(view: self)
        presenter?.viewDidLoad(tableView: tableView)
        hideKeyboardOnTap()
        tableView.prefetchDataSource = self
    }
    
    
    // MARK: User Interface
    // Скрыть клавиатуру (по нажатию на экран)
    func hideKeyboardOnTap() {
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideAction)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    // Убираем header (делал высоту отступа сверху слишком большой)
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    
    // MARK: Конфигурация и настройка таблицы
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.heightForRowAt(indexPath: indexPath) ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.cellForRowAt(tableView: tableView, indexPath: indexPath) ?? UITableViewCell() 
    }
}


// MARK: Обновление таблицы
extension NewsTableVC: NewsTableUpdater {
    func updateTable() {
        tableView.reloadData()
    }
}


// MARK: Дозагрузка новостей
extension NewsTableVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        presenter?.prefetchRowsAt(indexPaths: indexPaths)
    }
}
