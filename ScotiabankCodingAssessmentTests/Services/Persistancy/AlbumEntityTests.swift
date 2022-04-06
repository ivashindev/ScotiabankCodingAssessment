//
//  ScotiabankCodingAssessmentTests.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import XCTest
@testable import ScotiabankCodingAssessment

class AlbumEntityTests: XCTestCase {
    
    func testCreate() {
        
        let albumId = 0
        let id = 0
        let title = "<title>"
        let url = "<url>"
        let thumbnailUrl = "<thumbnailUrl>"
        
        let albumEntity = AlbumEntity.create(withAlbumId: albumId,
                                             id: id,
                                             title: title,
                                             url: url,
                                             thumbnailUrl: thumbnailUrl)
        
        XCTAssertEqual(albumEntity.albumId, albumId)
        XCTAssertEqual(albumEntity.id, id)
        XCTAssertEqual(albumEntity.title, title)
        XCTAssertEqual(albumEntity.url, url)
        XCTAssertEqual(albumEntity.thumbnailUrl, thumbnailUrl)
    }
    
    func testToAlbum() {
        
        let albumId = 0
        let id = 0
        let title = "<title>"
        let url = "<url>"
        let thumbnailUrl = "<thumbnailUrl>"
        
        let albumEntity = AlbumEntity.create(withAlbumId: albumId,
                                             id: id,
                                             title: title,
                                             url: url,
                                             thumbnailUrl: thumbnailUrl)
        
        let album = albumEntity.toAlbum()
        
        XCTAssertEqual(albumEntity.albumId, album.albumId)
        XCTAssertEqual(albumEntity.id, album.id)
        XCTAssertEqual(albumEntity.title, album.title)
        XCTAssertEqual(albumEntity.url, album.url)
        XCTAssertEqual(albumEntity.thumbnailUrl, album.thumbnailUrl)
    }
}
