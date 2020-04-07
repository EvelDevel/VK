
//  Created by Евгений Никитин on 15.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit
import Alamofire
import WebKit
import PromiseKit

class VKApi {
    
    typealias Out = Swift.Result
    private let vkURL = "https://api.vk.com/method/"
    
    
    // MARK: Универсальная дженерик-функция для API-request
    func sendRequest<T: Decodable>(url: String, method: HTTPMethod = .get, parameters: Parameters) -> Promise<[T]> {
        
        return Promise<[T]> { resolver in
            Alamofire.request(url, method: method, parameters: parameters).responseData { response in
                switch response.result {
                case let .failure(error):
                    print("\(ApplicationErrors.badRequest)")
                    resolver.reject(error)
                case let .success(data):
                    do {
                        let result = try JSONDecoder().decode(CommonResponse<T>.self, from: data)
                        resolver.fulfill(result.response.items)
                    } catch {
                        resolver.reject(ApplicationErrors.parsingFailed)
                    }
                }
            }
        }
    }
    
    
    // MARK: Список друзей
    func getFriendList(token: String, userID: String) -> Promise<[FriendsItems]> {
        let url = vkURL + "friends.get"
        let parameters = ["user_id"         : userID,
                          "access_token"    : token,
                          "order"           : "name",
                          "fields"          : "photo_50",
                          "v"               : "5.103"]
        
        return sendRequest(url: url, parameters: parameters)
    }
    
    
    // MARK: Фотографии
    func getPhotos(token: String, userID: String) -> Promise<[PhotosItems]> {
        let url = vkURL + "photos.getAll"
        let parameters = ["access_token"    : token,
                          "owner_id"        : userID,
                          "album_id"        : "profile",
                          "extended"        : "1",
                          "photo_sizes"     : "1",
                          "v"               : "5.103"]
        
        return sendRequest(url: url, parameters: parameters)
    }
    
    
    // MARK: Cписок групп
    func getGroups(token: String, userID: String) -> Promise<[GroupsItems]> {
        let url = vkURL + "groups.get"
        let parameters = ["access_token"    : token,
                          "owner_id"        : userID,
                          "extended"        : "1",
                          "fields"          : "activity,id",
                          "v"               : "5.103"]
        
        return sendRequest(url: url, parameters: parameters)
    }
    
    
    // MARK: Список новостей (Отдельный реквест без дженерика)
    func getNewsfeed(token: String,
                     userID: String,
                     nextFrom: String?,
                     completion: @escaping (Out<([Item], [FriendsItems], [GroupsItems], String), Error>) -> Void) {
        
        let url = vkURL + "newsfeed.get"
        let parameters = ["access_token"    : token,
                          "owner_id"        : userID,
                          "v"               : "5.103",
                          "filters"         : "post",
                          "return_banned"   : "0",
                          "count"           : "30",
                          "start_from"      : nextFrom ?? ""]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            self.getNewsfeedService(response: response, completion: completion)
            // print(String(bytes: response.value!, encoding: .utf8)!)
        }
    }
}


// MARK: Расширение "асинхронный парсинг новостей"
extension VKApi {
    func getNewsfeedService(response: DataResponse<Data>,
                           completion: @escaping (Out<([Item], [FriendsItems], [GroupsItems], String), Error>) -> Void) {

        /// Инициализация джейсона, декодера и группы
        let decoder = JSONDecoder()
        let dispatchGroup = DispatchGroup()
        guard let json = response.value else { completion(.failure(ApplicationErrors.parsingFailed)); return }
        
        /// Асинхронный парсинг в глобальном потоке
        var newsParsingResult: Alamofire.Result<NewsWrapper.NewsContainer>?
        var groupsParsingResult: Alamofire.Result<[GroupsItems]>?
        var usersParsingResult: Alamofire.Result<[FriendsItems]>?
        
        /// Создаем запросы на эти массивы асинхронно в глобальном потоке
        DispatchQueue.global().async(group: dispatchGroup) {
            newsParsingResult = .init { try decoder.decode(NewsWrapper.self, from: json).response }
        }
        DispatchQueue.global().async(group: dispatchGroup) {
            groupsParsingResult = .init { try decoder.decode(GroupsWrapper.self, from: json).response.groups }
        }
        DispatchQueue.global().async(group: dispatchGroup) {
            usersParsingResult = .init { try decoder.decode(UsersWrapper.self, from: json).response.profiles }
        }
        
        /// Когда все задачи завершились  - присваиваем значение
        dispatchGroup.notify(queue: .main) {
            if case let .success(newsContainer) = newsParsingResult,
                case let .success(profiles) = usersParsingResult,
                case let .success(groups) = groupsParsingResult {
                completion(.success((newsContainer.items, profiles, groups, newsContainer.nextFrom)))
                return
            }
            completion(.failure(ApplicationErrors.parsingFailed))
        }
    }
}



// MARK: - Версия реквеста новостей до асинхронного парсинга
/*
 do {
 /// Если нужно стянуть сырой джейсон для квик-тайпа
 /// print(String(bytes:response.data!, encoding: .utf8)!)
 
 let result = try JSONDecoder().decode(CommonResponseNews.self, from: response.value!)
 
 let news = result.response.items
 let profiles = result.response.profiles
 let groups = result.response.groups
 completion(.success((news, profiles, groups)))
 
 } catch {
 completion(.failure(ServerError.notReacheable))
 }
*/
