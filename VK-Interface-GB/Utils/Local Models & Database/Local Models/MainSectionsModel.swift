
//  Created by Евгений Никитин on 06.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

/// Модель ссылки-раздела на странице "Ещё"
/// Друзья / Сообщества / Музыка / Видео / Фотографии etc

class MainSectionsModel {
    var icon: UIImage
    var name: String
    
    init(icon: UIImage, name: String) {
        self.icon = icon
        self.name = name
    }
}
