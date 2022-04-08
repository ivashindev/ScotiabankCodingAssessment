//
//  Track.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Foundation

struct Track: Codable, Equatable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

extension Track {
    func toTrackEntity() -> TrackEntity {
        return TrackEntity.create(withAlbumId: albumId,
                                  id: id,
                                  title: title,
                                  url: url,
                                  thumbnailUrl: thumbnailUrl)
    }
}
