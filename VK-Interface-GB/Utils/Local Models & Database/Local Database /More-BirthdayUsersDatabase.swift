
//  Created by Евгений Никитин on 08.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

class BirthdayUsersDatabase {
    static func getBirthdayUsers() -> [BirthdayUsersModel] {
        return [
            BirthdayUsersModel(avatar: "user", username: "Евгений Никитин", isToday: true, sendGift: UIImage(systemName: "gift.fill")!, when: "Сегодня исполняется 30 лет"),
            BirthdayUsersModel(avatar: "user2", username: "Тор Иванович", isToday: true, sendGift: UIImage(systemName: "gift.fill")!,  when: "Сегодня исполняется 22 года"),
            BirthdayUsersModel(avatar: "user3", username: "Аскольд Петрович", isToday: false, sendGift: UIImage(systemName: "gift.fill")!, when: "Завтра исполняется 10 лет"),
            BirthdayUsersModel(avatar: "user4", username: "Шакур Тупакович", isToday: false, sendGift: UIImage(systemName: "gift.fill")!, when: "Завтра исполняется 85 лет"),
            BirthdayUsersModel(avatar: "user5", username: "Бэби Йода", isToday: false, sendGift: UIImage(systemName: "gift.fill")!, when: "Завтра исполняется 8 лет"),
        ]
    }
}
