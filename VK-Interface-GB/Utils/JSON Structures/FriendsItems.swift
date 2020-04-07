
//  Created by Евгений Никитин on 02.12.2019.
//  Реализация структур для парсинга JSON-а по друзьям ВК

import UIKit

// MARK: Основная сущность друга
struct FriendsItems: Decodable {
    var id: Int
    var name: String
    var lastname: String
    var photo: String
    var deactivated: String?
    
    enum CodingKeys: String, CodingKey {
        case id, deactivated
        case name = "first_name"
        case lastname = "last_name"
        case photo = "photo_50"
    }
    
    // Приведение FriendsItems к Realm-объекту
    func toRealm() -> FriendsRealm {
        let friendsToRealm = FriendsRealm()
        friendsToRealm.id = id
        friendsToRealm.name = name
        friendsToRealm.lastname = lastname
        friendsToRealm.photo = photo
        friendsToRealm.deactivated = deactivated
        return friendsToRealm
    }
}

