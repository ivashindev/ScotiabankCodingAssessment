//
//  ScotiabankCodingAssessmentTests.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import XCTest
import Combine
@testable import ScotiabankCodingAssessment

class AlbumsFetchServiceTests: XCTestCase {
    
    var httpsClientSpy: HTTPSClientSpy!
    var databaseSpy: DatabaseSpy!
    
    override func setUp() {
        httpsClientSpy = HTTPSClientSpy()
        databaseSpy = DatabaseSpy()
    }
    
    func testFetchedAlbums() {
        
        let expectation = XCTestExpectation(description: "")
        
        let jsonEncoder = JSONEncoder()
        let stubbedAlbums = [
            Album(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Album(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        let stubbedAlbumsData = try! jsonEncoder.encode(stubbedAlbums)
        
        httpsClientSpy.stubbedRequestResult = Future<Data, Error> { promise in
            promise(.success(stubbedAlbumsData))
        }.eraseToAnyPublisher()
        
        let albumsFetchService = AlbumsFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        var fetchedAlbums: [Album] = []
        
        _ = albumsFetchService
            .fetchAlbums()
            .sink { _ in
                
            } receiveValue: { albums in
                fetchedAlbums = albums
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(fetchedAlbums, stubbedAlbums)
        XCTAssertEqual(databaseSpy.invokedGetAlbumItemsCount, 1)
        XCTAssertEqual(databaseSpy.invokedClearCount, 1)
        XCTAssertEqual(databaseSpy.invokedSetAlbumItemsCount, 1)
    }
    
    func testFetchedSameAlbumsSet() {
        
        let expectation = XCTestExpectation(description: "")
        
        let jsonEncoder = JSONEncoder()
        let stubbedAlbums = [
            Album(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Album(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        let stubbedAlbumsData = try! jsonEncoder.encode(stubbedAlbums)
        
        httpsClientSpy.stubbedRequestResult = Future<Data, Error> { promise in
            promise(.success(stubbedAlbumsData))
        }.eraseToAnyPublisher()
        
        databaseSpy.stubbedGetAlbumItemsResult = stubbedAlbums.map { $0.toAlbumItemEntity() }
        
        let albumsFetchService = AlbumsFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        var fetchedAlbums: [Album] = []
        
        _ = albumsFetchService
            .fetchAlbums()
            .sink { _ in
                
            } receiveValue: { albums in
                fetchedAlbums = albums
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(fetchedAlbums, stubbedAlbums)
        XCTAssertEqual(databaseSpy.invokedGetAlbumItemsCount, 1)
        XCTAssertEqual(databaseSpy.invokedClearCount, 0)
        XCTAssertEqual(databaseSpy.invokedSetAlbumItemsCount, 0)
    }
    
    func testFetchedAlbumsEmptyArrayError() {
        
        let expectation = XCTestExpectation(description: "")
        
        let jsonEncoder = JSONEncoder()
        let stubbedAlbums: [Album] = []
        let stubbedAlbumsData = try! jsonEncoder.encode(stubbedAlbums)
        
        httpsClientSpy.stubbedRequestResult = Future<Data, Error> { promise in
            promise(.success(stubbedAlbumsData))
        }.eraseToAnyPublisher()
        
        let albumsFetchService = AlbumsFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        var fetchedAlbums: [Album] = []
        
        _ = albumsFetchService
            .fetchAlbums()
            .sink { error in
                expectation.fulfill()
            } receiveValue: { albums in
                fetchedAlbums = albums
            }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(fetchedAlbums, stubbedAlbums)
        XCTAssertEqual(databaseSpy.invokedGetAlbumItemsCount, 1)
        XCTAssertEqual(databaseSpy.invokedClearCount, 0)
        XCTAssertEqual(databaseSpy.invokedSetAlbumItemsCount, 0)
    }
    
    func testGetCachedAlbums() {
        let stubbedAlbums = [
            Album(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Album(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        
        databaseSpy.stubbedGetAlbumItemsResult = stubbedAlbums.map { $0.toAlbumItemEntity() }
        let albumsFetchService = AlbumsFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        let fetchedAlbums = albumsFetchService.getCachedAlbums()
        
        XCTAssertEqual(databaseSpy.invokedGetAlbumItemsCount, 1)
        XCTAssertEqual(fetchedAlbums, stubbedAlbums)
    }
    
    func testGetCachedAlbumsError() {
        
        databaseSpy.stubbedGetAlbumItemsError = NSError(domain: "test", code: 001, userInfo: nil)
        let albumsFetchService = AlbumsFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        
        let fetchedAlbums = albumsFetchService.getCachedAlbums()
        
        XCTAssertEqual(databaseSpy.invokedGetAlbumItemsCount, 1)
        XCTAssertEqual(fetchedAlbums, [])
    }
}
