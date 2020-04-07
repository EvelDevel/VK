
//  Created by Евгений Никитин on 14.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

// Модель "Добавить историю" для хозяина страницы
class AddStroiesModel {
    var avatarPath: String
    var username: String        
    
    init(avatarPath: String, username: String) {
        self.avatarPath = avatarPath
        self.username = username
    }
}
