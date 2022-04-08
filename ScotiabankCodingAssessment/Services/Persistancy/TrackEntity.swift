//
//  TrackEntity.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import RealmSwift

class TrackEntity: Object {
    
    @objc dynamic private(set) var albumId: Int = 0
    @objc dynamic private(set) var id: Int = 0
    @objc dynamic private(set) var title: String = ""
    @objc dynamic private(set) var url: String = ""
    @objc dynamic private(set) var thumbnailUrl: String = ""
    
    static func create(withAlbumId albumId: Int,
                       id: Int,
                       title: String,
                       url: String,
                       thumbnailUrl: String) -> TrackEntity {
        let entity = TrackEntity()
        entity.albumId = albumId
        entity.id = id
        entity.title = title
        entity.url = url
        entity.thumbnailUrl = thumbnailUrl
        return entity
    }
}

extension TrackEntity {
    func toTrack() -> Track {
        return Track(albumId: albumId,
                     id: id,
                     title: title,
                     url: url,
                     thumbnailUrl: thumbnailUrl)
    }
}
