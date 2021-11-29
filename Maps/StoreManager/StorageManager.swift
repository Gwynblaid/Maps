//
//  StorageManager.swift
//  Maps
//
//  Created by Sergey Harchenko on 28.11.2021.
//

// TODO: Сделать реактивным
protocol StorageManager {
    func save<ObjectType: StorageObject>(_ object: ObjectType) -> Bool
    func save<ObjectType: StorageObject>(_ objects: Set<ObjectType>) -> Bool
    
    func get<ObjectType: StorageObject>(_ id: ObjectType.ID) -> ObjectType?
    func getAll<ObjectType: StorageObject>() -> Set<ObjectType>
    
    func remove<ObjectType: StorageObject>(with id: ObjectType.ID) -> ObjectType?
    func remove<ObjectType: StorageObject>(_ object: ObjectType) -> Bool
    func remove<ObjectType: StorageObject>(_ ojects: Set<ObjectType>) -> Bool
    func removeAll<ObjectType: StorageObject>() -> Set<ObjectType>
}

extension StorageManager {
    func save<ObjectType: StorageObject>(_ object: ObjectType) -> Bool {
        save(Set([object]))
    }
    
    func removeAll<ObjectType: StorageObject>() -> Set<ObjectType> {
        let allObjects: Set<ObjectType> = getAll()
        _ = remove(allObjects)
        return allObjects
    }
    
    func remove<ObjectType: StorageObject>(with id: ObjectType.ID) -> ObjectType? {
        guard let object: ObjectType = get(id) else {
            return nil
        }
        if remove(object) {
            return object
        }
        return nil
    }
    
    func remove<ObjectType: StorageObject>(_ object: ObjectType) -> Bool {
        remove(Set([object]))
    }
}
