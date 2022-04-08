//
//  ScotiabankCodingAssessmentTests.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import XCTest
@testable import ScotiabankCodingAssessment

class TrackEntityTests: XCTestCase {
    
    func testCreate() {
        
        let albumId = 0
        let id = 0
        let title = "<title>"
        let url = "<url>"
        let thumbnailUrl = "<thumbnailUrl>"
        
        let trackEntity = TrackEntity.create(withAlbumId: albumId,
                                             id: id,
                                             title: title,
                                             url: url,
                                             thumbnailUrl: thumbnailUrl)
        
        XCTAssertEqual(trackEntity.albumId, albumId)
        XCTAssertEqual(trackEntity.id, id)
        XCTAssertEqual(trackEntity.title, title)
        XCTAssertEqual(trackEntity.url, url)
        XCTAssertEqual(trackEntity.thumbnailUrl, thumbnailUrl)
    }
    
    func testToTrack() {
        
        let albumId = 0
        let id = 0
        let title = "<title>"
        let url = "<url>"
        let thumbnailUrl = "<thumbnailUrl>"
        
        let trackEntity = TrackEntity.create(withAlbumId: albumId,
                                             id: id,
                                             title: title,
                                             url: url,
                                             thumbnailUrl: thumbnailUrl)
        
        let track = trackEntity.toTrack()
        
        XCTAssertEqual(trackEntity.albumId, track.albumId)
        XCTAssertEqual(trackEntity.id, track.id)
        XCTAssertEqual(trackEntity.title, track.title)
        XCTAssertEqual(trackEntity.url, track.url)
        XCTAssertEqual(trackEntity.thumbnailUrl, track.thumbnailUrl)
    }
}
