
//  Created by Евгений Никитин on 24.01.2020.
//  Реализация повторяющихся частей структур для парсинга (чтобы не дублировать код)
//  Подходят эти структуры трем сущностям: Friend, Photo, Group

/// https://geekbrains.ru/lessons/56621 (начало лекции)

import Foundation

struct CommonResponse<T: Decodable>: Decodable {
    var response: CommonResponseArray<T>
}

struct CommonResponseArray<T: Decodable>: Decodable {
    var items: [T]
}
