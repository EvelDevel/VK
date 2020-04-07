
//  Created by Евгений Никитин on 28.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

// Модель "Истории" пользователя
class StoriesModel {
    
    var avatarPath: String      // Аватарка
    var watchStatus: Bool       // Просмотрено или нет?
    var username: String        // Имя пользователя
    var blueRadius: UIView      // Сам синий круг
    var usernameColor: UIColor  // Цвет текста имени
    
    init(avatarPath: String, watchStatus: Bool, username: String, blueRadius: UIView, usernameColor: UIColor) {
        self.avatarPath = avatarPath
        self.watchStatus = watchStatus
        self.username = username
        self.blueRadius = blueRadius
        self.usernameColor = usernameColor
    }
}
