
//  Created by Евгений Никитин on 21.01.2020.
//  Объекты Realm для групп (сохранение в БД)

import Foundation
import RealmSwift

class GroupsRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    @objc dynamic var type = ""
    @objc dynamic var id = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_50"
        case type = "activity"
        case id
    }
    
    // По "name" наша БД будет проверять пользователей (при совпадении: перезаписывает а не дублирует)
    override class func primaryKey() -> String? {
        return "id"
    }
}
