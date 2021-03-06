
//  Created by Евгений Никитин on 11.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

// MARK: - Иммитация списка сообщений пользователя
class MessageDatabase {
    static func getMessage() -> [MessageModel] {
        
        return [
        MessageModel(avatarPath: "user",
                username: "Никитин Евгений",
                messageTime: "14:52",
                messageText: "Лицо Снегга исказилось от ярости, и он быстро отпустил край мантии. Профессор явно не хотел, чтобы Гарри увидел его покалеченную ногу. Гарри судорожно сглотнул воздух"),
        
        MessageModel(avatarPath: "user4",
                username: "Никитина Татьяна",
                messageTime: "02:01",
                messageText: "Нет, это невозможно, — возразила она.—Я знаю, что он не очень приятный человек, но он не стал бы пытаться украсть то, что прячет в замке Дамблдор"),
        
        MessageModel(avatarPath: "user5",
                username: "Сергей Хлимоненко",
                messageTime: "21:20",
                messageText: "Честное слово, Гермиона, тебя послушать, так все преподаватели просто святые, — горячо возразил Рон. — Лично я согласен с Гарри. Снегг может быть замешан в чем угодно. Но за чем именно он охотится? Что охраняет этот пес?"),
        
        MessageModel(avatarPath: "user6",
                username: "Георгий Ворожейкин",
                messageTime: "08:43",
                messageText: "Тебе надо хоть что-нибудь съесть, — озабоченно заметила Гермиона, увидев, что Гарри сидит перед пустой тарелкой"),
        
        MessageModel(avatarPath: "user7",
                username: "Борис Петин",
                messageTime: "Пн",
                messageText: "Гарри, тебе надо набраться сил, — пришел на помощь Гермионе Симус Финниган. — Против ловцов всегда играют грубее, чем против всех остальных"),
        
        MessageModel(avatarPath: "user",
                username: "Андрей Никитин",
                messageTime: "Пн",
                messageText: "Я ничего не хочу, — отрезал Гарри"),
        
        MessageModel(avatarPath: "user1",
                username: "Иван Кадочников",
                messageTime: "Вт",
                messageText: "Хотя бы один ломтик поджаренного хлеба, -настаивала она"),
        
        MessageModel(avatarPath: "user2",
                username: "Иван Иванов",
                messageTime: "Ср",
                messageText: "Спасибо, Симус, — с горькой иронией поблагодарил Гарри, глядя, как Финниган поливает сосиски кетчупом"),
        
        MessageModel(avatarPath: "user3",
                username: "Мария Ивановна",
                messageTime: "Чт",
                messageText: "К одиннадцати часам стадион был забит битком — казалось, здесь собралась вся школа. У многих в руках были бинокли. Трибуны были расположены высоко над землей, но тем не менее порой с них сложно было разглядеть то, что происходит в небе"),
       
        MessageModel(avatarPath: "user4",
                username: "Рик Санчез",
                messageTime: "Сб",
                messageText: "Проклятая тварь, — произнес Снегг. — Хотел бы я знать, сможет ли кто-нибудь следить одновременно за всеми тремя головами и пастями и избежать того, чтобы одна из них его не цапнула?"),
        
        MessageModel(avatarPath: "user5",
                username: "Морти Санчез",
                messageTime: "Пт",
                messageText: "Поняли, что все это значит? — выдохнул он, закончив рассказ.—Он пытался пройти мимо того трехголового пса, и это случилось в Хэллоуин! Мы с Роном искали тебя, чтобы предупредить насчет тролля, и увидели его в коридоре — он направлялся именно туда! Он охотится за тем, что охраняет пес! И готов поспорить на свою метлу, что это он впустил в замок тролля, чтобы отвлечь внимание и посеять панику, а самому спокойно похитить то, зачем он охотится!"),
        
        MessageModel(avatarPath: "user6",
                username: "Борис Пупкин",
                messageTime: "12 Дек",
                messageText: "Честное слово, Гермиона, тебя послушать, так все преподаватели просто святые, — горячо возразил Рон. — Лично я согласен с Гарри. Снегг может быть замешан в чем угодно. Но за чем именно он охотится? Что охраняет этот пес?"),
        
        MessageModel(avatarPath: "user7",
                username: "Стивен Спилберг",
                messageTime: "11 Дек",
                messageText: "Когда Гарри оказался в постели, голова у него шла кругом от тех же самых вопросов. Рядом громко храпел Невилл. Но и без этого звукового сопровождения Гарри вряд ли смог бы заснуть. Он пытался очистить голову от мыслей — он должен был выспаться, просто обязан, ведь через несколько часов ему предстояло впервые в жизни выйти на поле. Но не так-то легко было забыть выражение лица Снегга, когда тот понял, что Гарри увидел его изуродованную ногу")
        ]
    }
}
