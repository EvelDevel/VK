
//  Created by Евгений Никитин on 02.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit
import RealmSwift
 
protocol PhotosPresenter {
    func viewDidLoad(collectionToUpdate: UICollectionView)
    func numberOfItemsInSection(section: Int) -> Int
    func getPhotoModel(indexPath: IndexPath) -> PhotosRealm?
    func cellRegistration(collection: UICollectionView)
    func photoCellCustomization(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

class PhotosPresenterImplementation: PhotosPresenter {
    
    private var vkAPI: VKApi
    private var database: PhotosSource
    private var photoCollection: Results<PhotosRealm>!
    private var userID: String = ""
    private var token: NotificationToken?
    private weak var collection: PhotosCollectionUpdater?
    
    init(database: PhotosSource, view: PhotosCollectionUpdater, userID: String) {
        vkAPI = VKApi()
        self.database = database
        self.collection = view
        self.userID = userID
    }
    
    func viewDidLoad(collectionToUpdate: UICollectionView) {
        getPhotosFromDatabase(collectionToUpdate: collectionToUpdate)
        getPhotosFromApi()
    }
    
    deinit {
        token?.invalidate()
    }
    
    // Получаем фотографии из базы данных
    private func getPhotosFromDatabase(collectionToUpdate: UICollectionView) {
        do {
            self.photoCollection = try database.getAllPhotos(userID: userID)
            
            self.token = self.photoCollection.observe {
                [weak self] result in
                guard let collectionView = self?.collection else { return }
                
                switch result {
                case .update(_, let deletions, let insertions, let modifications):
                    collectionToUpdate.performBatchUpdates({
                        collectionToUpdate.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                        collectionToUpdate.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                        collectionToUpdate.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                    }, completion: nil)
                case .initial:
                    collectionView.updateCollection()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
        } catch {
            print(error)
        }
    }
    
    // API-request (Работа с апи-запросом обернута в Promise Kit)
    func getPhotosFromApi() {
        vkAPI.getPhotos(token: UserSession.defaultSession.token, userID: userID)
        .done { photos in
            self.database.addPhotos(photos: photos, ownerID: self.userID)
        } .catch { error in
            print("\(ApplicationErrors.getPhotosFromApiError): \(error)") 
        }
    }
}


// MARK: Кастомизация таблицы
extension PhotosPresenterImplementation {
    /// Регистрация прототипа
    func cellRegistration(collection: UICollectionView) {
        collection.register(UINib.init(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    /// Получаем количество элементов
    func numberOfItemsInSection(section: Int) -> Int {
        return photoCollection.count
    }
    /// Модель ячейки
    func getPhotoModel(indexPath: IndexPath) -> PhotosRealm? {
        return photoCollection[indexPath.item]
    }
    /// Кастомизация ячейки
    func photoCellCustomization(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell,
            let model = getPhotoModel(indexPath: indexPath) else {
                return UICollectionViewCell()
        }
        /// Статус "мой лайк"
        cell.likes.liked = model.likes?.isLiked == 1 ? true : false
        
        /// Количество лайков под фото
        cell.likes.likeCount = model.likes?.count ?? 0
        
        /// Фотографии
        if let url = URL(string: model.sizes.first(where: {
            $0.type == "x" || $0.type == "y" || $0.type == "z"  })?.url ?? "") {
            cell.photo.kf.setImage(with: url)
        }
        return cell
    }
}
