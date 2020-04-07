
//  Created by Евгений Никитин on 26.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import RealmSwift

protocol FriendsSource {
    func getAllUsers() throws -> Results<FriendsRealm>
    func addUsers(users: [FriendsItems])
    func searchFriends(name: String) throws -> Results<FriendsRealm>
}

class FriendsRepository: FriendsSource {
    
    // MARK: Получить всех пользователей из БД 
    func getAllUsers() throws -> Results<FriendsRealm> {
        do {
            let realm = try Realm()
            return realm.objects(FriendsRealm.self).filter("deactivated == nil")
        } catch { throw error }
    }
    
    
    // MARK: Добавить всех пользователей в БД
    func addUsers(users: [FriendsItems]) {
        do {
            let realm = try! Realm()
            try realm.write() {
                let usersArray = users.map { $0.toRealm() }
                realm.add(usersArray, update: .modified)
            }
        } catch { print(error) }
    }
    
    
    // MARK: Поиск юзеров по локальному репозиторию
    func searchFriends(name: String) throws -> Results<FriendsRealm> {
        do {
            let realm = try Realm()
            return realm.objects(FriendsRealm.self).filter("name CONTAINS[c] %@ OR lastname CONTAINS[c] %@", name, name)
        } catch { throw error }
    }
}
