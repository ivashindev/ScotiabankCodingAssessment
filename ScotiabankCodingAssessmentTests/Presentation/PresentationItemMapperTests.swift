//
//  ScotiabankCodingAssessmentTests.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import XCTest
@testable import ScotiabankCodingAssessment

class PresentationItemMapperTests: XCTestCase {
    
    func testMapToTracksDictionary() {
        let albumsDictionaryInput: [Int: [PresentationItem]] = [
            0: [PresentationItem(id: 2,
                                 title: "<title>",
                                 coverImageURL: URL(string: "https://")),
                PresentationItem(id: 0,
                                 title: "<title>",
                                 coverImageURL: nil),
                PresentationItem(id: 1,
                                 title: "<title>",
                                 coverImageURL: nil)],
            1: [PresentationItem(id: 2,
                                 title: "<title>",
                                 coverImageURL: URL(string: "https://")),
                PresentationItem(id: 0,
                                 title: "<title>",
                                 coverImageURL: nil),
                PresentationItem(id: 1,
                                 title: "<title>",
                                 coverImageURL: nil)]
        ]
        
        let albumsExpectedOutput: [PresentationItem] = [
            PresentationItem(id: 0,
                             title: "Album 0",
                             coverImageURL: URL(string: "https://")),
            PresentationItem(id: 1,
                             title: "Album 1",
                             coverImageURL: URL(string: "https://"))
        ]
        
        let albums = PresentationItemMapper.mapToAlbumPresentationItems(from: albumsDictionaryInput)
        
        XCTAssertEqual(albums, albumsExpectedOutput)
    }
    
    func testMapToPresentationItems() {
        let tracksInput = [
            Track(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Track(albumId: 0,
                  id: 1,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Track(albumId: 1,
                  id: 1,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        
        let expectedAlbumsDictionaryOutput = [
            0: [
                PresentationItem(id: 0,
                                 title: "<title>",
                                 coverImageURL: nil),
                PresentationItem(id: 1,
                                 title: "<title>",
                                 coverImageURL: nil)
            ],
            1: [
                PresentationItem(id: 1,
                                 title: "<title>",
                                 coverImageURL: nil)
            ]
        ]
        
        let albumsDictionary = PresentationItemMapper.mapToAlbumsDictionary(from: tracksInput)
        
        XCTAssertEqual(albumsDictionary, expectedAlbumsDictionaryOutput)
    }
}
