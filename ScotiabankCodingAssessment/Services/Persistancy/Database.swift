//
//  PersistantStorage.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import Foundation
import RealmSwift

protocol Database {
    func setAlbumItems(_ items: [AlbumEntity]) throws
    func getAlbumItems() throws -> [AlbumEntity]
}

class RealmDatabase: Database {
    
    func setAlbumItems(_ items: [AlbumEntity]) throws {
        let realm = try Realm()
        try! realm.write {
            try Realm().add(items)
        }
    }
    
    func getAlbumItems() throws -> [AlbumEntity]  {
        let realm = try Realm()
        return realm.objects(AlbumEntity.self).map { $0 }
    }
}
