//
//  ScotiabankCodingAssessmentTests.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import XCTest
import Combine
@testable import ScotiabankCodingAssessment

class TracksFetchServiceTests: XCTestCase {
    
    var httpsClientSpy: HTTPSClientSpy!
    var databaseSpy: DatabaseSpy!
    
    override func setUp() {
        httpsClientSpy = HTTPSClientSpy()
        databaseSpy = DatabaseSpy()
    }
    
    func testFetchedTracks() {
        
        let expectation = XCTestExpectation(description: "")
        
        let jsonEncoder = JSONEncoder()
        let stubbedTracks = [
            Track(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Track(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        let stubbedTracksData = try! jsonEncoder.encode(stubbedTracks)
        
        httpsClientSpy.stubbedRequestResult = Future<Data, Error> { promise in
            promise(.success(stubbedTracksData))
        }.eraseToAnyPublisher()
        
        let tracksFetchService = TracksFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        var fetchedTracks: [Track] = []
        
        _ = tracksFetchService
            .fetchTracks()
            .sink { _ in
                
            } receiveValue: { tracks in
                fetchedTracks = tracks
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(fetchedTracks, stubbedTracks)
        XCTAssertEqual(databaseSpy.invokedGetTracksCount, 1)
        XCTAssertEqual(databaseSpy.invokedClearCount, 1)
        XCTAssertEqual(databaseSpy.invokedSetTracksCount, 1)
    }
    
    func testFetchedSameTracksSet() {
        
        let expectation = XCTestExpectation(description: "")
        
        let jsonEncoder = JSONEncoder()
        let stubbedTracks = [
            Track(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Track(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        let stubbedTracksData = try! jsonEncoder.encode(stubbedTracks)
        
        httpsClientSpy.stubbedRequestResult = Future<Data, Error> { promise in
            promise(.success(stubbedTracksData))
        }.eraseToAnyPublisher()
        
        databaseSpy.stubbedGetTracksResult = stubbedTracks.map { $0.toTrackEntity() }
        
        let tracksFetchService = TracksFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        var fetchedTracks: [Track] = []
        
        _ = tracksFetchService
            .fetchTracks()
            .sink { _ in
                
            } receiveValue: { tracks in
                fetchedTracks = tracks
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(fetchedTracks, stubbedTracks)
        XCTAssertEqual(databaseSpy.invokedGetTracksCount, 1)
        XCTAssertEqual(databaseSpy.invokedClearCount, 0)
        XCTAssertEqual(databaseSpy.invokedSetTracksCount, 0)
    }
    
    func testFetchedTracksEmptyArrayError() {
        
        let expectation = XCTestExpectation(description: "")
        
        let jsonEncoder = JSONEncoder()
        let stubbedTracks: [Track] = []
        let stubbedTracksData = try! jsonEncoder.encode(stubbedTracks)
        
        httpsClientSpy.stubbedRequestResult = Future<Data, Error> { promise in
            promise(.success(stubbedTracksData))
        }.eraseToAnyPublisher()
        
        let tracksFetchService = TracksFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        var fetchedTracks: [Track] = []
        
        _ = tracksFetchService
            .fetchTracks()
            .sink { error in
                expectation.fulfill()
            } receiveValue: { tracks in
                fetchedTracks = tracks
            }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(fetchedTracks, stubbedTracks)
        XCTAssertEqual(databaseSpy.invokedGetTracksCount, 1)
        XCTAssertEqual(databaseSpy.invokedClearCount, 0)
        XCTAssertEqual(databaseSpy.invokedSetTracksCount, 0)
    }
    
    func testGetCachedTracks() {
        let stubbedTracks = [
            Track(albumId: 0,
                  id: 0,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>"),
            Track(albumId: 1,
                  id: 2,
                  title: "<title>",
                  url: "<url>",
                  thumbnailUrl: "<thumbnailUrl>")
        ]
        
        databaseSpy.stubbedGetTracksResult = stubbedTracks.map { $0.toTrackEntity() }
        let tracksFetchService = TracksFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        let fetchedTracks = tracksFetchService.getCachedTracks()
        
        XCTAssertEqual(databaseSpy.invokedGetTracksCount, 1)
        XCTAssertEqual(fetchedTracks, stubbedTracks)
    }
    
    func testGetCachedTracksError() {
        
        databaseSpy.stubbedGetTracksError = NSError(domain: "test", code: 001, userInfo: nil)
        let tracksFetchService = TracksFetchService(httpsClient: httpsClientSpy,
                                                    database: databaseSpy)
        
        let fetchedTracks = tracksFetchService.getCachedTracks()
        
        XCTAssertEqual(databaseSpy.invokedGetTracksCount, 1)
        XCTAssertEqual(fetchedTracks, [])
    }
}
