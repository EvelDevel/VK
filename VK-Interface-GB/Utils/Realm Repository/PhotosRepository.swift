
//  Created by Евгений Никитин on 26.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import RealmSwift

protocol PhotosSource {
    func getAllPhotos(userID: String) throws -> Results<PhotosRealm>
    func addPhotos(photos: [PhotosItems], ownerID: String)
}

class PhotosRepository: PhotosSource { 
    
    // MARK: Получаем все фото из БД
    func getAllPhotos(userID: String) throws -> Results<PhotosRealm> {
        do {
            let realm = try Realm()
            return realm.objects(PhotosRealm.self).filter("ownerID == %@", Int(userID)!)
        } catch { throw error }
    }
    
    
    // MARK: Добавляем все фото в БД
    func addPhotos(photos: [PhotosItems], ownerID: String) {
        do {
            let realm = try! Realm()
            try realm.write() {
                let photosDict = PhotosDictionary()
                let photosToAdd = photos.map { $0.toRealm() }
                photosDict.userID = ownerID
                photosDict.photos.append(objectsIn: photosToAdd)
                realm.add(photosDict, update: .modified)
            }
        } catch { print(error) }
    }
}
