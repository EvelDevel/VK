
//  Created by Евгений Никитин on 21.01.2020.
//  Объекты Realm для друзей (сохранение в БД)

import RealmSwift

class FriendsRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var lastname = ""
    @objc dynamic var photo = ""
    @objc dynamic var deactivated: String?
    
    enum CodingKeys: String, CodingKey {
        case id, deactivated
        case name = "first_name"
        case lastname = "last_name"
        case photo = "photo_50"
    }
    
    // Проверка для перезаписи
    override class func primaryKey() -> String? {
        return "id"
    }
    
    // Индексируем нужные свойства, для ускорения работы по фильтрации
    override class func indexedProperties() -> [String] {
        return ["lastname", "name", "deactivated"]
    }
}
