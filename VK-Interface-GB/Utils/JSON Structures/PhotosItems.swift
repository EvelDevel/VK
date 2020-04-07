
//  Created by Евгений Никитин on 18.01.2020.
//  Реализация структур для парсинга JSON-а по фотографиям пользователя ВК

import UIKit

// MARK: Основная сущность фотографии
struct PhotosItems: Decodable {
    var albumID: Int
    var date: Int
    var id: Int
    var ownerID: Int
    var text: String?
    var sizes: [PhotoSizes]
    var likes: Like
    
    enum CodingKeys: String, CodingKey {
        case date, id, text, sizes, likes
        case albumID = "album_id"
        case ownerID = "owner_id"
    }
    
    func toRealm() -> PhotosRealm {
        let photoToRealm = PhotosRealm()
        photoToRealm.albumID = albumID
        photoToRealm.date = date
        photoToRealm.id = id
        photoToRealm.ownerID = ownerID
        photoToRealm.text = text
        photoToRealm.sizes.append(objectsIn: sizes.map { $0.toRealm() })
        photoToRealm.likes = likes.toRealm()
        return photoToRealm
    }
}


// MARK: Размеры фотографий
struct PhotoSizes: Decodable {
    var url: String
    var type: String
    var width: Int
    var height: Int
    var aspectRatio: CGFloat? {
        guard width != 0 else { return nil }
        return CGFloat(height) / CGFloat(width)
    }
    
    // Функция для превращения sizes к типу Realm (#7)
    func toRealm() -> PhotoSizesRealm {
        let photoRealm = PhotoSizesRealm()
        photoRealm.url = url
        photoRealm.type = type
        photoRealm.width = width
        photoRealm.height = height
        return photoRealm
    }
}


// MARK: Лайки
struct Like: Decodable {
    var isLiked: Int
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case isLiked = "user_likes"
        case count
    }
    
    func toRealm() -> LikeRealm {
        let likeRealm = LikeRealm()
        likeRealm.count = count
        likeRealm.isLiked = isLiked
        return likeRealm
    }
}
