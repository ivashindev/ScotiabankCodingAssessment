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
        
        let stubbedAlbums = [
            Album(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Album(albumId: 0,
                  id: 1,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "https://"),
            Album(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "https://"),
            Album(albumId: 1,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        
        let albumsRepositorySpy = AlbumsRepositorySpy()
        
        albumsRepositorySpy.stubbedFetchAlbumsResult = Future<[Album], Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                promise(.success(stubbedAlbums))
                expectation.fulfill()
            }
        }.eraseToAnyPublisher()
        
        let albumsViewModel = AlbumsViewModel(albumsFetchService: albumsRepositorySpy)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(albumsRepositorySpy.invokedFetchAlbumsCount, 1)
        XCTAssertEqual(albumsViewModel.presentationItems, [PresentationItem(id: 0,
                                                                            title: "Album 0",
                                                                            coverImageURL: nil),
                                                           PresentationItem(id: 1,
                                                                            title: "Album 1",
                                                                            coverImageURL: nil)])
        XCTAssertEqual(albumsViewModel.tracksMap, [1:
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
        
        let stubbedAlbums = [
            Album(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Album(albumId: 0,
                  id: 1,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "https://"),
            Album(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "https://"),
            Album(albumId: 1,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        
        let albumsRepositorySpy = AlbumsRepositorySpy()
        
        albumsRepositorySpy.stubbedFetchAlbumsResult = Future<[Album], Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                promise(.success(stubbedAlbums))
                expectation.fulfill()
            }
        }.eraseToAnyPublisher()
        
        let albumsViewModel = AlbumsViewModel(albumsFetchService: albumsRepositorySpy)
        
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
