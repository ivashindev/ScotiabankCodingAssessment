//
//  PersistantStorage.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import Foundation
import RealmSwift

protocol Database {
    func setTracks(_ tracks: [TrackEntity]) throws
    func getTracks() throws -> [TrackEntity]
    func clear() throws
}

class RealmDatabase: Database {
    
    func setTracks(_ tracks: [TrackEntity]) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(tracks)
        }
    }
    
    func getTracks() throws -> [TrackEntity]  {
        let realm = try Realm()
        return realm.objects(TrackEntity.self).map { $0 }
    }
    
    func clear() throws {
        let realm = try Realm()
        try realm.write {
            realm.deleteAll()
        }
    }
}
