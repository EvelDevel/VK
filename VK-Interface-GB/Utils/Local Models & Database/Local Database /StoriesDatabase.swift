
//  Created by Евгений Никитин on 28.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

// Контент для блока "Историй" друзей
class StoriesDatabase {
    
    static func getAuthor() -> [AddStroiesModel] {
        return [
            AddStroiesModel(avatarPath: "user", username: "Евгений")
        ]
    }
    
    static func getStories() -> [StoriesModel] {
        return [            
            StoriesModel(avatarPath: "user2",
                         watchStatus: true,
                         username: "Таня",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user3",
                         watchStatus: true,
                         username: "Сергей",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user4",
                         watchStatus: true,
                         username: "Николай",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user5",
                         watchStatus: true,
                         username: "Оксана",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user6",
                         watchStatus: true,
                         username: "Надежда",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user7",
                         watchStatus: false,
                         username: "Георгий",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user",
                         watchStatus: false,
                         username: "Алексей",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user2",
                         watchStatus: false,
                         username: "Иван",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user3",
                         watchStatus: false,
                         username: "Дарья",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user4",
                         watchStatus: false,
                         username: "Ирина",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user5",
                         watchStatus: false,
                         username: "Валя",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user6",
                         watchStatus: false,
                         username: "Ольга",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)),
            
            StoriesModel(avatarPath: "user7",
                         watchStatus: false,
                         username: "Арина",
                         blueRadius: UIView(),
                         usernameColor: #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1))
        ]
    }
}

