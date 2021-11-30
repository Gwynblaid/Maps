//
//  StorageManagerMock.swift
//  Maps
//
//  Created by Sergey Harchenko on 30.11.2021.
//

@testable import Maps
import Foundation

final class StorageManagerMock: StorageManager {
    enum Input {
        case saveObject(entity: String, hash: Int)
        case saveObjects(entity: String, hashes: [Int])
        case getObject(entity: String, idHash: Int)
        case getAll(entity: String)
        case remove(entity: String, idHash: Int)
        case removeObject(entity: String, hash: Int)
        case removeObjects(entity: String, hashes: [Int])
        case removeAll(entity: String)
    }
    
    private(set) var inputs: [Input] = []
    
    func save<ObjectType: StorageObject>(_ object: ObjectType) -> Bool {
        inputs.append(
            .saveObject(
                entity: ObjectType.entityName,
                hash: object.hashValue
            )
        )
        return true
    }
    func save<ObjectType: StorageObject>(_ objects: Set<ObjectType>) -> Bool {
        inputs.append(
            .saveObjects(
                entity: ObjectType.entityName,
                hashes: objects.map(\.hashValue)
            )
        )
        return true
    }

    func get<ObjectType: StorageObject>(_ id: ObjectType.ID) -> ObjectType? {
        inputs.append(
            .getObject(
                entity: ObjectType.entityName,
                idHash: id.hashValue
            )
        )
        return nil
    }
    
    func getAll<ObjectType: StorageObject>() -> Set<ObjectType> {
        inputs.append(.getAll(entity: ObjectType.entityName))
        return []
    }
    
    func remove<ObjectType: StorageObject>(with id: ObjectType.ID) -> ObjectType? {
        inputs.append(
            .remove(
                entity: ObjectType.entityName,
                idHash: id.hashValue
            )
        )
        return nil
    }
    
    func remove<ObjectType: StorageObject>(_ object: ObjectType) -> Bool {
        inputs.append(
            .removeObject(
                entity: ObjectType.entityName,
                hash: object.hashValue
            )
        )
        return true
    }
    
    func remove<ObjectType: StorageObject>(_ objects: Set<ObjectType>) -> Bool {
        inputs.append(
            .removeObjects(
                entity: ObjectType.entityName,
                hashes: objects.map(\.hashValue)
            )
        )
        return true
    }
    
    func removeAll<ObjectType: StorageObject>() -> Set<ObjectType> {
        inputs.append(.removeAll(entity: ObjectType.entityName))
        return []
    }
}
