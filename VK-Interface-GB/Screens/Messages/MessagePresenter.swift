
//  Created by Евгений Никитин on 09.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

protocol MessagePresenter {
    func viewDidLoad()
    func cellCustomization(tableView: UITableView)
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}

class MessagePresenterImplementation: MessagePresenter {
    func viewDidLoad() { }
}


// MARK: Кастомизация таблицы
extension MessagePresenterImplementation {
    /// Регистрация прототипа и настройка высоты ячейки
    func cellCustomization(tableView: UITableView) {
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "SimpleMessage")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    /// Количество ячеек
    func numberOfRowsInSection(section: Int) -> Int {
        return MessageDatabase.getMessage().count
    }
    /// Наполняем ячейку (шаблон)
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleMessage", for: indexPath) as? MessageCell else { return UITableViewCell() }
        /// Заполняем нужной информацией
        cell.message.text = MessageDatabase.getMessage()[indexPath.row].messageText
        cell.avatar.image = UIImage(named: MessageDatabase.getMessage()[indexPath.row].avatarPath)
        cell.time.text = MessageDatabase.getMessage()[indexPath.row].messageTime
        cell.username.text = MessageDatabase.getMessage()[indexPath.row].username
        return cell
    }
}
