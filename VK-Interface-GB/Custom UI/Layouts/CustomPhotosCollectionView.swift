
//  Created by Евгений Никитин on 12.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

enum CollectionCustomSize {
    case small
    case wide
}

/// Курс "Пользовательский интерфейс (№1), Вебинар №6

class CustomPhotosCollectionView: UICollectionViewLayout {
    
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var maxColumns = 3
    var cellHeight: CGFloat = 100
    var containerHeight: CGFloat = 0
    private var totalCellsHeight: CGFloat = 0
    
    // Алгоритм размещения
    override func prepare() {
        
        self.cacheAttributes = [:]
        guard let collectionView = self.collectionView else { return }
        
        let photoCounter = collectionView.numberOfItems(inSection: 0)
        guard photoCounter > 0 else { return }
        var cellHeight: CGFloat = 0
        var lastX: CGFloat = 0
        var lastY: CGFloat = 0
        
        // Запускаем цикл прохода по всем фотографиям
        for i in 0..<photoCounter {
            var cellWidth: CGFloat = 0
            let indexPath = IndexPath(item: i, section: 0)
            let attributeForIndex = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            cellWidth = collectionView.frame.width / 3
            cellHeight = cellWidth
            
            attributeForIndex.frame = CGRect(
                x: lastX,
                y: lastY,
                width: cellWidth,
                height: cellHeight)
            
            if ((i + 1) % maxColumns) == 0 {
                lastY += cellHeight
                lastX = 0
            } else {
                lastX += cellWidth
            }
            
            cacheAttributes[indexPath] = attributeForIndex
        }
        containerHeight = lastY + cellHeight
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter {
            rect.intersects($0.frame)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.width ?? 0,
                      height: containerHeight)
    }
}
