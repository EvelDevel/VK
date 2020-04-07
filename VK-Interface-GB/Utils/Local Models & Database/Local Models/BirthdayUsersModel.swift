
//  Created by Евгений Никитин on 08.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

/// Модель "Пользователь, у которого завтра или послезавтра день рождения"

class BirthdayUsersModel {
    var avatar:     String
    var username:   String
    var isToday:    Bool
    var sendGift:   UIImage 
    var when:       String
    
    init(avatar: String, username: String, isToday: Bool, sendGift: UIImage, when: String) {
        self.avatar =   avatar
        self.username = username
        self.isToday =  isToday
        self.sendGift = sendGift
        self.when =     when
    }
}


