
//  Created by Евгений Никитин on 12.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit
import Kingfisher

class NewsPhotosCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var photosToShow: [NewsAttachment] = []
    @IBOutlet weak var photosInNews: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photosInNews.dataSource = self
        self.photosInNews.delegate = self
        self.photosInNews.register(UINib.init(nibName: "PhotosInNews", bundle: nil), forCellWithReuseIdentifier: "PhotosInNews")
    }
}

// MARK: Расширение для кастомизации фотографий
extension NewsPhotosCell {
    
    /// Количество фоток
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosToShow.count
    }
    
    /// Заполнение
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosInNews", for: indexPath as IndexPath) as? PhotosInNews
            else { return UICollectionViewCell() }
        
        /// Берем нужные размеры фото и кешируем с помощью Kingfisher
        if let url = URL(string: photosToShow[indexPath.row].photo!.sizes.first(where: {
            $0.type == "x" || $0.type == "y" || $0.type == "z"  })?.url ?? "") {
            photoCell.photo.kf.setImage(with: url)
        }
        return photoCell
    }
}
