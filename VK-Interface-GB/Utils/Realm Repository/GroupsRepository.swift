
//  Created by Евгений Никитин on 26.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import RealmSwift

protocol GroupsSource {
    func getAllGroups() throws -> Results<GroupsRealm>
    func addGroups(groups: [GroupsItems])
    func searchGroups(name: String) throws -> Results<GroupsRealm>
    func deleteGroup(id: Int)
}

class GroupsRepository: GroupsSource {
    
    // MARK: Получить все группы из БД
    func getAllGroups() throws -> Results<GroupsRealm> {
        do {
            let realm = try Realm()
            return realm.objects(GroupsRealm.self)
        } catch { throw error }
    }
    
    
    // MARK: Добавить все группы в БД
    func addGroups(groups: [GroupsItems]) {
        do {
            let realm = try! Realm()
            try realm.write() {
                let groupsToAdd = groups.map { $0.toRealm() }
                realm.add(groupsToAdd, update: .modified)
            }
        } catch { print("Возникла ошибка при добавлении всех групп в БД: \(error)") }
    }
    
    
    // MARK: Поиск групп
    func searchGroups(name: String) throws -> Results<GroupsRealm> {
        do {
            let realm = try Realm()
            return realm.objects(GroupsRealm.self).filter("name CONTAINS[c] %@", name)
        } catch { throw error }
    }
    
    
    // MARK: Удалить группу
    func deleteGroup(id: Int) {
        do {
            let realm = try Realm()
            try realm.write {
                let object = realm.object(ofType: GroupsRealm.self, forPrimaryKey: id)
                realm.delete(object!)
            }
        } catch { print("Возникла ошибка при удалении группы из БД: \(error)") }
    }
}
