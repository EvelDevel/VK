
//  Created by Евгений Никитин on 09.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

enum NewsCellTypes {
    case header, text, attachment, footer
}

protocol NewsPresenter {
    func viewDidLoad(tableView: UITableView)
    func cellRegistration(tableView: UITableView)
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func prefetchRowsAt(indexPaths: [IndexPath])
}

class NewsPresenterImplementation: NewsPresenter {
    private var vkAPI: VKApi
    private var items: [Item] = []
    private var profiles: [FriendsItems] = []
    private var groups: [GroupsItems] = []
    private var nextFrom: String = ""
    private var cellsToDisplay: [NewsCellTypes] = [.header, .text, .attachment, .footer]
    private weak var view: NewsTableUpdater?
    private var stringDatesCache = [IndexPath: String]()
    private var isFetchingMoreNews = false
    
    init(view: NewsTableUpdater) {
        self.vkAPI = VKApi()
        self.view = view
    }
    
    func viewDidLoad(tableView: UITableView) {
        getNewsFromApi()
        cellRegistration(tableView: tableView)
    }
    
    // API-запрос новостей
    func getNewsFromApi() {
        isFetchingMoreNews = true
        vkAPI.getNewsfeed(token: UserSession.defaultSession.token, userID: UserSession.defaultSession.id, nextFrom: nextFrom) {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items, profiles, groups, nextFrom):
                self.items.append(contentsOf: items)
                self.profiles.append(contentsOf: profiles)
                self.groups.append(contentsOf: groups)
                self.nextFrom = nextFrom
                self.view?.updateTable()
            case .failure(let error):
                print("\(ApplicationErrors.getNewsfeedError): \(error)")
            }
            self.isFetchingMoreNews = false
        }
    }
}


// MARK: Настройки таблицы
extension NewsPresenterImplementation {
    /// Регистрируем прототипы
    func cellRegistration(tableView: UITableView) {
        tableView.register(UINib(nibName: "WhatIsNewCell", bundle: nil), forCellReuseIdentifier: "WhatIsNewCell")
        tableView.register(UINib(nibName: "FriendsStoriesCell", bundle: nil), forCellReuseIdentifier:  "FriendsStoriesCell")
        tableView.register(UINib(nibName: "NewsHeaderCell", bundle: nil), forCellReuseIdentifier: "NewsHeaderCell")
        tableView.register(UINib(nibName: "NewsTextCell", bundle: nil), forCellReuseIdentifier: "NewsTextCell")
        tableView.register(UINib(nibName: "NewsPhotosCell", bundle: nil), forCellReuseIdentifier: "NewsPhotosCell")
        tableView.register(UINib(nibName: "NewsFooterCell", bundle: nil), forCellReuseIdentifier: "NewsFooterCell")
        tableView.register(UINib(nibName: "NewsOtherTypeAttachmentCell", bundle: nil), forCellReuseIdentifier:  "NewsOtherTypeAttachmentCell")
    }
    /// Количество секций
    func numberOfSections() -> Int {
        if self.items.count == 0 {
            return 2 + items.count
        } else {
            return items.count
        }
    }
    /// Количество ячеек
    func numberOfRowsInSection(section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            return 4
        }
    }
    /// Высота секций и ячеек
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let sectionNumber = indexPath.section
        let rowHeightOfCurrentSection = cellsToDisplay[indexPath.row]
        
        switch sectionNumber {
        case 0:
            return 60
        case 1:
            return 102
        default:
            
            switch rowHeightOfCurrentSection {
            case .header:
                return 65
            case .text:
                return UITableView.automaticDimension
            case .attachment:
                return attachmentRowHeight(indexPath: indexPath)
            case .footer:
                return 40
            }
        }
    }
}


// MARK: Расчет высоты ячеек
extension NewsPresenterImplementation {
    func attachmentRowHeight(indexPath: IndexPath) -> CGFloat {
        let currentAttachment = items[indexPath.section].attachments
        
        /// Если внутри аттача есть вложения "photo"
        if currentAttachment != nil && currentAttachment?[0].type == "photo" {
            if currentAttachment?.count == 1 {
                return 220
            }
            else if currentAttachment?.count == 2 {
                return 200
            }
            else if currentAttachment?.count == 3 {
                return 150
            }
            else {
                return 350
            }
            
        /// Если любое другое вложение
        } else if currentAttachment?[0].type != "photo" && currentAttachment != nil {
            return 70
        /// Если репост
        } else if items[indexPath.section].copyHistory != nil {
            return 80
        /// Если пусто
        } else {
            return 0
        }
    }
}


// MARK: Кастомизация каждой секции с новостью
extension NewsPresenterImplementation {
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let whatIsNew = tableView.dequeueReusableCell(withIdentifier: "WhatIsNewCell") as? WhatIsNewCell
            return whatIsNew ?? UITableViewCell()
        }
        else if indexPath.section == 1 {
            let stroriesCell = tableView.dequeueReusableCell(withIdentifier: "FriendsStoriesCell") as? FriendsStoriesCell
            return stroriesCell ?? UITableViewCell()
        }
        else {
            let sourceId = items[indexPath.section].sourceID
            
            switch cellsToDisplay[indexPath.row] {
            case .header:
                return headerCellCreation(  indexPath:  indexPath,
                                            tableView:  tableView,
                                            sourceId:   sourceId)
            case .text:
                return textCellCreation(    indexPath:  indexPath,
                                            tableView:  tableView)
            case .attachment:
                return attachCellCreation(  indexPath:  indexPath,
                                            tableView:  tableView)
            case .footer:
                return footerCellCreation(  indexPath:  indexPath,
                                            tableView:  tableView)
            }
        }
    }
    
    
    // MARK: Ячейка Header
    private func headerCellCreation(indexPath: IndexPath, tableView: UITableView, sourceId: Int) -> UITableViewCell {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderCell", for: indexPath) as? NewsHeaderCell
            else { return UITableViewCell() }
        
        /// Оптимизация даты (работа через Cache)
        let dateString: String?
        if stringDatesCache[indexPath] != nil {
            dateString = stringDatesCache[indexPath]
        } else {
            dateString = DateTimeHelper.getFormattedDate(from: Date(timeIntervalSince1970: TimeInterval(items[indexPath.section].date)))
            DispatchQueue.main.async { self.stringDatesCache[indexPath] = dateString }
        }
        header.time.text = dateString
        
        /// Подбор по айдишнику аватарки пользователя / группы (автор новости)
        for account in profiles {
            if sourceId == account.id * -1 || sourceId == account.id {
                header.username.text = account.name + " " + account.lastname
                if let url = URL(string: account.photo) {
                    header.avatar.kf.setImage(with: url)
                }
            }
        }
        for group in groups {
            if sourceId == group.id * -1 || sourceId == group.id {
                header.username.text = group.name
                if let url = URL(string: group.photo) {
                    header.avatar.kf.setImage(with: url)
                }
            }
        }
        return header
    }
    
    
    // MARK: Ячейка Text
    private func textCellCreation(indexPath:   IndexPath, tableView:   UITableView) -> UITableViewCell {
        guard let text = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as? NewsTextCell
            else { return UITableViewCell() }
        text.postText.text = items[indexPath.section].text
        return text
    }
    
    
    // MARK: Ячейка вложений
    private func attachCellCreation(indexPath:  IndexPath, tableView:  UITableView) -> UITableViewCell {
        if items[indexPath.section].attachments?[0].type == "photo" {
            guard let photos = tableView.dequeueReusableCell(withIdentifier: "NewsPhotosCell", for: indexPath) as? NewsPhotosCell
                else { return UITableViewCell() }
            
            var itemsToSend: [NewsAttachment] = []
            for item in items[indexPath.section].attachments ?? [] {
                if item.type == "photo" {
                    itemsToSend.append(item)
                }
            }
            photos.photosToShow = itemsToSend
            photos.photosInNews.reloadData()
            return photos
        }
        else {
            guard let attach = tableView.dequeueReusableCell(withIdentifier: "NewsOtherTypeAttachmentCell", for: indexPath)
                as? NewsOtherTypeAttachmentCell
                else { return UITableViewCell() }
            return attach
        }
    }
    
    
    // MARK: Ячейка Footer
    private func footerCellCreation(indexPath:  IndexPath,tableView:  UITableView) -> UITableViewCell {
        guard let footer = tableView.dequeueReusableCell(withIdentifier: "NewsFooterCell", for: indexPath) as? NewsFooterCell
            else { return UITableViewCell() }
        
        /// Статус "мой лайк"
        footer.likes.liked = items[indexPath.section].likes?.isLiked == 1 ? true : false
        
        /// Количество лайков, комментариев и репостов
        footer.likes.likeCount = items[indexPath.section].likes?.count ?? 0
        footer.comments.commentsCounter = items[indexPath.section].comments?.count ?? 0
        footer.repost.repostCounter = items[indexPath.section].reposts?.count ?? 0
        
        /// Количество просмотров (приведение к привычкому виду)
        if let viewsCounter = items[indexPath.section].views?.count {
            if viewsCounter < 1000 {
                footer.viewsCounter.text = String(viewsCounter)
            } else {
                footer.viewsCounter.text = String(viewsCounter / 1000) + " k"
            }
        }
        return footer
    }
}


// MARK: Дозагрузка новостей
extension NewsPresenterImplementation {
    func prefetchRowsAt(indexPaths: [IndexPath]) {
        guard !isFetchingMoreNews,
            let maxSection = indexPaths.map({ $0.section }).max(),
            items.count <= maxSection + 2 else { return }
        getNewsFromApi()
    }
}

