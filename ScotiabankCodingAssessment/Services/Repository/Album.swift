//
//  AlbumItem.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Foundation

struct Album: Codable, Equatable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

extension Album {
    func toAlbumItemEntity() -> AlbumEntity {
        return AlbumEntity.create(withAlbumId: albumId,
                                      id: id,
                                      title: title,
                                      url: url,
                                      thumbnailUrl: thumbnailUrl)
    }
}
