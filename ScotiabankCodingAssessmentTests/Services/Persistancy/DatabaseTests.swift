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
        
        let albumEntity = AlbumEntity.create(withAlbumId: 0,
                                             id: 0,
                                             title: "<title>",
                                             url: "<url>",
                                             thumbnailUrl: "<thumbnailUrl>")
        let albumEntities = [albumEntity]
        
        let database = RealmDatabase()
        try! database.clear()
        
        try! database.setAlbumItems(albumEntities)
        let expectedAlbumEntities = try! database.getAlbumItems()
        let expectedAlbumEntitiy = expectedAlbumEntities.first!
        
        XCTAssertEqual(albumEntity.albumId, expectedAlbumEntitiy.albumId)
        XCTAssertEqual(albumEntity.id, expectedAlbumEntitiy.id)
        XCTAssertEqual(albumEntity.title, expectedAlbumEntitiy.title)
        XCTAssertEqual(albumEntity.url, expectedAlbumEntitiy.url)
        XCTAssertEqual(albumEntity.thumbnailUrl, expectedAlbumEntitiy.thumbnailUrl)
    }
}
