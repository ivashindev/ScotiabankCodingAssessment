//
//  ScotiabankCodingAssessmentTests.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import XCTest
import Combine
@testable import ScotiabankCodingAssessment

class AlbumsViewModelTests: XCTestCase {
    
    func testInit() {
        let expectation = XCTestExpectation(description: "")
        
        let stubbedTracks = [
            Track(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Track(albumId: 0,
                  id: 1,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "https://"),
            Track(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "https://"),
            Track(albumId: 1,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        
        let tracksRepositorySpy = TracksRepositorySpy()
        
        tracksRepositorySpy.stubbedFetchTracksResult = Future<[Track], Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                promise(.success(stubbedTracks))
                expectation.fulfill()
            }
        }.eraseToAnyPublisher()
        
        let albumsViewModel = AlbumsViewModel(tracksFetchService: tracksRepositorySpy)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(tracksRepositorySpy.invokedFetchTracksCount, 1)
        XCTAssertEqual(albumsViewModel.presentationItems, [PresentationItem(id: 0,
                                                                            title: "Album 0",
                                                                            coverImageURL: nil),
                                                           PresentationItem(id: 1,
                                                                            title: "Album 1",
                                                                            coverImageURL: nil)])
        XCTAssertEqual(albumsViewModel.albumsMap, [1:
                                                    [PresentationItem(id: 0,
                                                                      title: "<title>",
                                                                      coverImageURL: nil),
                                                     PresentationItem(id: 2,
                                                                      title: "<title>",
                                                                      coverImageURL: URL(string: "https://"))],
                                                   0:
                                                    [PresentationItem(id: 0,
                                                                      title: "<title>",
                                                                      coverImageURL: nil),
                                                     PresentationItem(id: 1,
                                                                      title: "<title>",
                                                                      coverImageURL: URL(string: "https://"))]])
    }
    
    func testWillPresentTracksView() {
        let expectation = XCTestExpectation(description: "")
        
        let stubbedTracks = [
            Track(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Track(albumId: 0,
                  id: 1,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "https://"),
            Track(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "https://"),
            Track(albumId: 1,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        
        let tracksRepositorySpy = TracksRepositorySpy()
        
        tracksRepositorySpy.stubbedFetchTracksResult = Future<[Track], Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                promise(.success(stubbedTracks))
                expectation.fulfill()
            }
        }.eraseToAnyPublisher()
        
        let albumsViewModel = AlbumsViewModel(tracksFetchService: tracksRepositorySpy)
        
        wait(for: [expectation], timeout: 1.0)
        
        let tracks = albumsViewModel.willPresentTracksView(for: 0)
        
        XCTAssertEqual(tracks, [PresentationItem(id: 0,
                                                 title: "<title>",
                                                 coverImageURL: nil),
                                PresentationItem(id: 1,
                                                 title: "<title>",
                                                 coverImageURL: URL(string: "https://"))])
    }
}
