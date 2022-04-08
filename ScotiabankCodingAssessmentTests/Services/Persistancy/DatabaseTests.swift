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
        
        let trackEntity = TrackEntity.create(withAlbumId: 0,
                                             id: 0,
                                             title: "<title>",
                                             url: "<url>",
                                             thumbnailUrl: "<thumbnailUrl>")
        let trackEntities = [trackEntity]
        
        let database = RealmDatabase()
        try! database.clear()
        
        try! database.setTracks(trackEntities)
        let expectedTrackEntities = try! database.getTracks()
        let expectedTrackEntitiy = expectedTrackEntities.first!
        
        XCTAssertEqual(trackEntity.albumId, expectedTrackEntitiy.albumId)
        XCTAssertEqual(trackEntity.id, expectedTrackEntitiy.id)
        XCTAssertEqual(trackEntity.title, expectedTrackEntitiy.title)
        XCTAssertEqual(trackEntity.url, expectedTrackEntitiy.url)
        XCTAssertEqual(trackEntity.thumbnailUrl, expectedTrackEntitiy.thumbnailUrl)
    }
}
