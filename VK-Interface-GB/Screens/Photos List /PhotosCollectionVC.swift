
//  Created by Евгений Никитин on 01.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit
import Kingfisher

protocol PhotosCollectionUpdater: class {
    func updateCollection()
}

class PhotosCollectionVC: UICollectionViewController {
    
    @IBOutlet var collectionOutlet: UICollectionView!
    var presenter: PhotosPresenter?
    var configurator: PhotosConfigurator?
    var user: String?
    var userID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(view: self, userID: userID)
        presenter?.viewDidLoad(collectionToUpdate: collectionOutlet)
        updateNavigationBar()
        cellRegistration(collection: collectionOutlet)
        print("Перешли к юзеру: \(user ?? "---") с id: \(userID)")
    }
    
    // Кастомизируем Navigation Bar
    func updateNavigationBar() {
        self.title = user
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
    }
    
    
    // MARK: Конфигурация и настройка таблицы
    func cellRegistration(collection: UICollectionView) {
        presenter?.cellRegistration(collection: collection)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection(section: section) ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter?.photoCellCustomization(collectionView: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
    }
}


// MARK: Обновление коллекции
extension PhotosCollectionVC: PhotosCollectionUpdater {
    func updateCollection() {
        collectionView.reloadData()
    }
}
