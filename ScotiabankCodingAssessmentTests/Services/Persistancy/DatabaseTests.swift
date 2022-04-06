//
//  ScotiabankCodingAssessmentTests.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import XCTest
@testable import ScotiabankCodingAssessment

class DatabaseTests: XCTestCase {
    
    func testSetterAndGetter() {
        let albumEntities = [
            AlbumEntity.create(withAlbumId: 0,
                               id: 0,
                               title: "<title>",
                               url: "<url>",
                               thumbnailUrl: "<thumbnailUrl>"),
            AlbumEntity.create(withAlbumId: 1,
                               id: 1,
                               title: "<title>",
                               url: "<url>",
                               thumbnailUrl: "<thumbnailUrl>")
        ]
        
        let database = RealmDatabase()
        try! database.clear()
        
        try! database.setAlbumItems(albumEntities)
        let expectedAlbumEntities = try! database.getAlbumItems().sorted(by: { $0.albumId < $1.albumId })
    }
}
