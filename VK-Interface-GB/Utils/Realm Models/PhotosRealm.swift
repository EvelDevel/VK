
//  Created by Евгений Никитин on 21.01.2020.
//  Объекты Realm для фотографий пользователя (сохранение в БД)

import Foundation
import RealmSwift

class PhotosDictionary: Object {
    @objc dynamic var userID: String = ""
    var photos = List<PhotosRealm>()
    
    override class func primaryKey() -> String? {
        return "userID"
    }
}

class PhotosRealm: Object {
    @objc dynamic var albumID = 0
    @objc dynamic var date = 0
    @objc dynamic var id = 0
    @objc dynamic var ownerID = 0
    @objc dynamic var text: String?
    @objc dynamic var likes: LikeRealm?
    var sizes = List<PhotoSizesRealm>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class PhotoSizesRealm: Object {
    @objc dynamic var url = ""
    @objc dynamic var type = ""
    @objc dynamic var width = 0
    @objc dynamic var height = 0
}

class LikeRealm: Object {
    @objc dynamic var isLiked = 0
    @objc dynamic var count = 0
    
    enum CodingKeys: String, CodingKey {
        case isLiked = "user_likes"
        case count
    }
}
