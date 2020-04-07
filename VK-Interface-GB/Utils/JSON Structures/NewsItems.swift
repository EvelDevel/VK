
//  Created by Евгений Никитин on 23.02.2020.
//  Реализация структур для парсинга JSON-а по новостям ВК

import UIKit
import RealmSwift

// MARK: Обертки для асинхронного парсинга
/// Массив новостей, точка отсчета для следующей "порции"
struct NewsWrapper: Decodable {
    let response: NewsContainer
    
    struct NewsContainer: Decodable {
        let items: [Item]
        let nextFrom: String
        
        enum CodingKeys: String, CodingKey {
            case items
            case nextFrom = "next_from"
        }
    }
}

/// Массив групп - авторов новостей
struct GroupsWrapper: Decodable {
    let response: GroupsContainer
    
    struct GroupsContainer: Decodable {
        let groups: [GroupsItems]
    }
}

/// Массив пользователей - авторов новостей
struct UsersWrapper: Decodable {
    let response: UsersContainer
    
    struct UsersContainer: Decodable {
        let profiles: [FriendsItems]
    }
}


// MARK: Массив новостей для текущего пользователя
struct Item: Decodable {
    let sourceID: Int, date: Int
    let text: String?
    let attachments: [NewsAttachment]?
    let comments: NewsComments?
    let likes: Like?
    let reposts: NewsReposts?
    let views: NewsViews?
    let copyHistory: [CopyHistory]?
    
    enum CodingKeys: String, CodingKey {
        case date, text, attachments, comments, likes, reposts, views
        case sourceID = "source_id"
        case copyHistory = "copy_history"
    }
}

/// Массив объектов новости (фото, ссылка, etc)
struct NewsAttachment: Decodable {
    let type: String
    let photo: NewsPhoto?
}

/// Вложенный объект - фото (Reusing PhotoSizes)
struct NewsPhoto: Decodable {
    let sizes: [PhotoSizes]
}

/// Количество комментариев
struct NewsComments: Decodable {
    let count: Int
}

/// Количество просмотров
struct NewsViews: Decodable {
    let count: Int
}

/// Количество репостов
struct NewsReposts: Decodable {
    let count: Int
}


// MARK: Сущность приходящая при репосте
struct CopyHistory: Decodable {
    let id, ownerID, fromID, date: Int
    let text: String
    let attachments: [CopyHistoryAttachment]?
    
    enum CodingKeys: String, CodingKey {
        case id, date, text, attachments
        case ownerID = "owner_id"
        case fromID = "from_id"
    }
}

/// CopyHistoryAttachment
struct CopyHistoryAttachment: Decodable {
    let photo: NewsPhoto?
}


// MARK: - Прошлая верси до асинхронного парсинга
/*
 // MARK: Основная сущность для парсинга новости (топ иерархии)
 struct CommonResponseNews: Decodable {
 let response: NewsItems
 }
 
 // MARK: Сущность новости с контентом
 class NewsItems: Decodable {
 var items: [Item]
 var profiles: [FriendsItems]
 var groups: [GroupsItems]
 var nextFrom: String
 
 enum CodingKeys: String, CodingKey {
 case items, profiles, groups
 case nextFrom = "next_from"
 }
 }
*/


