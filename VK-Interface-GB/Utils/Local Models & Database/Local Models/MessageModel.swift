
//  Created by Евгений Никитин on 12.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class MessageModel {
    var avatarPath:     String
    var username:       String
    var messageTime:    String
    var messageText:    String
    
    init(avatarPath: String, username: String, messageTime: String, messageText: String) {
        self.avatarPath = avatarPath
        self.username = username
        self.messageText = messageText
        self.messageTime = messageTime
    }
}

