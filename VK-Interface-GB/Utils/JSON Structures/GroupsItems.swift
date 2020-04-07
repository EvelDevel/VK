
//  Created by Евгений Никитин on 02.12.2019.
//  Реализация структур для парсинга JSON-а по группам ВК

import UIKit

// MARK: Основная сущность группы
struct GroupsItems: Decodable {
    var name: String
    var photo: String
    var type: String?
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_50"
        case type = "activity"
        case id
    }
    
    func toRealm() -> GroupsRealm {
        let groupToRealm = GroupsRealm()
        groupToRealm.name = name
        groupToRealm.photo = photo
        groupToRealm.type = type ?? "" 
        groupToRealm.id = id
        return groupToRealm
    }
}
