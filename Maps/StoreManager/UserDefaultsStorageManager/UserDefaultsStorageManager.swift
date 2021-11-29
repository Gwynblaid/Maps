//
//  UserDefaultsStorageManager.swift
//  Maps
//
//  Created by Sergey Harchenko on 28.11.2021.
//

import Foundation

final class UserDefaultsStorageManager: StorageManager {
    private let userDefaults: UserDefaults
    private var cache: [String: Any]? = nil
    
    init(
        userDefaults: UserDefaults = .standard,
        isCaching: Bool = true
    ) {
        self.userDefaults = userDefaults
        if isCaching {
            cache = [:]
        }
    }
    
    func save<ObjectType>(_ objects: Set<ObjectType>) -> Bool where ObjectType : StorageObject {
        var saved: Set<ObjectType> = getAll()
        saved.formUnion(objects)
        cache?[ObjectType.entityName] = saved
        return setToUserDefault(objects)
    }
    
    func get<ObjectType>(_ id: ObjectType.ID) -> ObjectType? where ObjectType : StorageObject {
        let values: Set<ObjectType> = getAll()
        return values.first { $0.id == id }
    }
    
    func getAll<ObjectType>() -> Set<ObjectType> where ObjectType : StorageObject {
        guard let result = cache?[ObjectType.entityName] as? Set<ObjectType> else {
            let result: Set<ObjectType> = getFromUserDefault()
            cache?[ObjectType.entityName] = result
            return result
        }
        return result
    }

    func remove<ObjectType>(_ objects: Set<ObjectType>) -> Bool  where ObjectType : StorageObject {
        var saved: Set<ObjectType> = getAll()
        saved.subtract(objects)
        cache?[ObjectType.entityName] = saved
        return setToUserDefault(objects)
    }
    
    private func setToUserDefault<ObjectType: StorageObject>(_ objects: Set<ObjectType>) -> Bool {
        if objects.isEmpty {
            userDefaults.removeObject(forKey: ObjectType.entityName)
            return true
        }
        guard let data = try? JSONEncoder().encode(objects) else {
            return false
        }
        userDefaults.set(data, forKey: ObjectType.entityName)
        return true
    }
    
    private func getFromUserDefault<ObjectType: StorageObject>() -> Set<ObjectType> {
        let data = userDefaults.data(forKey: ObjectType.entityName) ?? Data()
        guard let result = try? JSONDecoder().decode(Set<ObjectType>.self, from: data) else {
            return Set<ObjectType>()
        }
        return result
    }
}
