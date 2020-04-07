
//  Created by Евгений Никитин on 30.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class ServicesCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Инициализируем шаблон и делегаты
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
    }

    // Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    // Кастомизация
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath as IndexPath) as! ServiceCell
        
        // Если будет необходимость:
        // 1. Создать модель "Сервис"
        // 2. Создать локальную "базу данных"
        // 3. Вывести их количество из БД
        // 4. Кастомизировать имена и аватарки
        
        /// Сейчас стоят заглушки, ничего нового в создании модели и симуляции БД - нет
        
        return cell
    }
}
