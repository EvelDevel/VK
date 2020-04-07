
//  Created by Евгений Никитин on 06.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

class MainSectionDatabase {
    static func shortListSection() -> [MainSectionsModel] {
        return [
            MainSectionsModel(icon: UIImage(systemName: "person.fill")!, name: "Друзья"),
            MainSectionsModel(icon: UIImage(systemName: "person.2.fill")!, name: "Сообщества"),
            MainSectionsModel(icon: UIImage(systemName: "music.note.list")!, name: "Музыка"),
            MainSectionsModel(icon: UIImage(systemName: "film")!, name: "Видео"),
            MainSectionsModel(icon: UIImage(systemName: "camera")!, name: "Фотографии")
        ]
    }
    
    static func allSection() -> [MainSectionsModel] {
        return [
            MainSectionsModel(icon: UIImage(systemName: "person.fill")!, name: "Друзья"),
            MainSectionsModel(icon: UIImage(systemName: "person.2.fill")!, name: "Сообщества"),
            MainSectionsModel(icon: UIImage(systemName: "music.note.list")!, name: "Музыка"),
            MainSectionsModel(icon: UIImage(systemName: "film")!, name: "Видео"),
            MainSectionsModel(icon: UIImage(systemName: "camera")!, name: "Фотографии"),
            MainSectionsModel(icon: UIImage(systemName: "creditcard")!, name: "Денежные переводы"),
            MainSectionsModel(icon: UIImage(systemName: "play.circle")!, name: "Трансляции"),
            MainSectionsModel(icon: UIImage(systemName: "star.fill")!, name: "Закладки"),
            MainSectionsModel(icon: UIImage(systemName: "suit.heart.fill")!, name: "Понравилось"),
            MainSectionsModel(icon: UIImage(systemName: "headphones")!, name: "Подкасты"),
            MainSectionsModel(icon: UIImage(systemName: "doc.fill")!, name: "Документы"),
            MainSectionsModel(icon: UIImage(systemName: "questionmark.circle.fill")!, name: "Помощь"),
            MainSectionsModel(icon: UIImage(systemName: "bag.fill")!, name: "Покупки"),
        ]
    }
}




