
//  Created by Евгений Никитин on 09.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

enum CellTypes {
    case profile
    case mainSections(item: MainSectionsModel)
    case showMoreMainSections
    case vkPay
    case services
    case birthdays
    case birthdayUser(item: BirthdayUsersModel)
}

protocol MorePresenter {
    func viewDidLoad(tableView: UITableView)
    func numberOfSections(tableView: UITableView) -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func didSelectRowAt(indexPath: IndexPath, navigationController: UINavigationController, tableView: UITableView)
}

class MorePresenterImplementation: MorePresenter {
    private var birthdayUsers: [CellTypes] = []     // Массив для 5-ой секции
    private var shortSections: [CellTypes] = []     // Массив для 2-ой секции
    private var allSections: [CellTypes] = []       // Массив со всеми разделами
    private var models: [[CellTypes]] = []          // Многомерный массив с контентом всей страницы
    private weak var view: MoreTableUpdater?
    
    init(view: MoreTableUpdater) {
        self.view = view
    }
    
    func viewDidLoad(tableView: UITableView) {
        addContent()
        cellRegistration(tableView: tableView)
    }
    
    // Наполняем контентом массивы
    func addContent() {
        /// Заполняем массив со всеми разделами для будущей перегрузки
        allSections.append(contentsOf: MainSectionDatabase.allSection().map { CellTypes.mainSections(item: $0) })
        /// Сначала наполним вторую секцию (гибкий список разделов + кнопка "еще")
        shortSections.append(contentsOf: MainSectionDatabase.shortListSection().map { CellTypes.mainSections(item: $0) })
        shortSections.append(.showMoreMainSections)
        /// Теперь добавим в массив с днями рождениями
        birthdayUsers.append(.birthdays)
        birthdayUsers.append(contentsOf: BirthdayUsersDatabase.getBirthdayUsers().map { CellTypes.birthdayUser(item: $0) })
        /// Теперь наполняем всеми секциями
        models.append([.profile])
        models.append(shortSections)
        models.append([.vkPay])
        models.append([.services])
        models.append(birthdayUsers)
    }
}


// MARK: Сборка и кастомизация всей таблицы
extension MorePresenterImplementation {
    /// Регистрируем прототипы
    func cellRegistration(tableView: UITableView) {
        tableView.register(UINib(nibName: "UserProfileCell", bundle: nil), forCellReuseIdentifier: "UserProfileCell")
        tableView.register(UINib(nibName: "OtherMainSectionsCell", bundle: nil), forCellReuseIdentifier: "OtherMainSectionsCell")
        tableView.register(UINib(nibName: "MoreOtherMainSectionsCell", bundle: nil), forCellReuseIdentifier: "MoreOtherMainSectionsCell")
        tableView.register(UINib(nibName: "VKPayCell", bundle: nil), forCellReuseIdentifier: "VKPayCell")
        tableView.register(UINib(nibName: "ServicesCell", bundle: nil), forCellReuseIdentifier: "ServicesCell")
        tableView.register(UINib(nibName: "BirthdaysCell", bundle: nil), forCellReuseIdentifier: "BirthdaysCell")
        tableView.register(UINib(nibName: "BirthdayUserCell", bundle: nil), forCellReuseIdentifier: "BirthdayUserCell")
    }
    /// Количество секций
    func numberOfSections(tableView: UITableView) -> Int {
        return models.count
    }
    /// Количество ячеек
    func numberOfRowsInSection(section: Int) -> Int {
        return models[section].count
    }
    /// Высота ячеек
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let row = models[indexPath.section][indexPath.row]
        switch row {
        case .profile: return 72
        case .mainSections: return 44
        case .showMoreMainSections: return 45
        case .vkPay: return 44
        case .services: return 155
        case .birthdays: return 50
        case .birthdayUser: return 72
        }
    }
    /// Кастомизация ячеек
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        
        let row = models[indexPath.section][indexPath.row]
        
        switch row {
        /// Верхняя секция "Открыть профиль"
        case .profile:
            let profile = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell") as? UserProfileCell
            return profile ?? UITableViewCell()
            
        /// Секция "Ссылки" (на другие важные разделы)
        case let .mainSections(item: section):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMainSectionsCell") as? OtherMainSectionsCell else {
                return UITableViewCell()
            }
            /// Конфигурируем содержание наших ячеек (ссылок на разделы)
            cell.icon.image = section.icon
            cell.name.text = section.name
            return cell
            
        /// Ячейка "Ещё" в секции "Ссылки"
        case .showMoreMainSections:
            let more = tableView.dequeueReusableCell(withIdentifier: "MoreOtherMainSectionsCell") as? MoreOtherMainSectionsCell
            return more ?? UITableViewCell()
            
        case .vkPay:
            let vkpay = tableView.dequeueReusableCell(withIdentifier: "VKPayCell") as? VKPayCell
            return vkpay ?? UITableViewCell()
            
        case .services:
            let services = tableView.dequeueReusableCell(withIdentifier: "ServicesCell") as? ServicesCell
            return services ?? UITableViewCell()
            
        /// Секция "Дни рождения"
        case .birthdays:
            let birthdays = tableView.dequeueReusableCell(withIdentifier: "BirthdaysCell") as? BirthdaysCell
            birthdays?.separatorInset.right = .greatestFiniteMagnitude // Убираем сепаратор у одной ячейки
            return birthdays ?? UITableViewCell()
            
        /// Ячейки с наступающими днями рождениями
        case let .birthdayUser(item: user):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayUserCell") as? BirthdayUserCell else {
                return UITableViewCell()
            }
            /// Подтягивание информации из "базы" и кастомизация
            cell.avatar.image = UIImage(named: user.avatar)
            cell.username.text = user.username
            cell.when.text = user.when
            cell.separatorInset.left = 80
            
            if user.isToday == true {
                cell.sendGift.image = user.sendGift
            } else {
                /// для Iphone-8 обязательно
                /// Чтобы не выводило лишним пользователям
                cell.sendGift.image = nil
            }
            return cell
        }
    }
}


// MARK: Обработка нажатий на ячейки
extension MorePresenterImplementation {
    func didSelectRowAt(indexPath: IndexPath,
                        navigationController: UINavigationController,
                        tableView: UITableView) {
        
        let row = models[indexPath.section][indexPath.row]
        
        switch row {
        case .profile: print("User press PROFILE")
            
        case let .mainSections(item: MoreMainSection):
            let name = MoreMainSection.name
            
            /// Начинаем вычислять на какую именно ячейку нажали
            switch name {
            case "Друзья":
                print("Нажали на раздел Друзья")
                let storyboard = UIStoryboard(name: "More", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "FriendsList") as! FriendsTableVC
                viewController.configurator = FriendsConfiguratorImplementation()
                navigationController.pushViewController(viewController, animated: true)
                
            case "Сообщества":
                print("Нажали на раздел Сообщества")
                let storyboard = UIStoryboard(name: "More", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "GroupList") as! GroupsTableVC
                viewController.configurator = GroupsConfiguratorImplementation()
                navigationController.pushViewController(viewController, animated: true)
                
            /// Временно не используемые разделы
            case "Музыка":              print("Нажали на раздел Музыка")
            case "Видео":               print("Нажали на раздел Видео")
            case "Фотографии":          print("Нажали на раздел Фотографии")
            case "Денежные переводы":   print("Нажали на раздел Денежные переводы")
            case "Трансляции":          print("Нажали на раздел Трансляции")
            case "Закладки":            print("Нажали на раздел Закладки")
            case "Понравилось":         print("Нажали на раздел Понравилось")
            case "Подкасты":            print("Нажали на раздел Подкасты")
            case "Документы":           print("Нажали на раздел Документы")
            case "Помощь":              print("Нажали на раздел Помощь")
            case "Покупки":             print("Нажали на раздел Покупки")
                
            /// Необходимый кейс (т.к. проверка идет по String)
            default: print("С разделами что-то пошло не так")
            }
            
        /// Ячейка "Ещё"
        case .showMoreMainSections:
            print("Нажали на раздел Еще")
            models.remove(at: 1)
            models.insert(allSections, at: 1)
            
            /// Начинаем апдейт таблицы
            tableView.beginUpdates()
            var indexPathsToInsert = [IndexPath]()
            /// Набираем IndexPath's для всех новых разделов (добавляя в массив)
            for index in 6..<models[1].indices.count {
                let currentIndex = IndexPath(row: index, section: 1)
                indexPathsToInsert.append(currentIndex)
            }
            /// Перегружаем строку "ещё", через insert нельзя, она существует в предыдущей версии
            let fifthRow = IndexPath(row: 5, section: 1)
            tableView.reloadRows(at: [fifthRow], with: UITableView.RowAnimation.fade)
            /// Добавляем все новые строки и заканчиваем апдейт
            tableView.insertRows(at: indexPathsToInsert, with: UITableView.RowAnimation.fade)
            tableView.endUpdates()
            
        case .vkPay:        print("Нажали на раздел VKPay")
        case .services:     print("Нажали на раздел SERVICES")
        case .birthdayUser: print("Нажали на раздел USERS WITH BIRTHDAY")
        case .birthdays:    print("Нажали на раздел BIRTHDAY")
        }
    }
}

