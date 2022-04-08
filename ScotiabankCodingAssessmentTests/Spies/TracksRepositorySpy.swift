//
//  File.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Combine
@testable import ScotiabankCodingAssessment

class TracksRepositorySpy: TracksRepository {

    var invokedFetchTracks = false
    var invokedFetchTracksCount = 0
    var stubbedFetchTracksResult: AnyPublisher<[Track], Error>!

    func fetchTracks() -> AnyPublisher<[Track], Error> {
        invokedFetchTracks = true
        invokedFetchTracksCount += 1
        return stubbedFetchTracksResult
    }

    var invokedGetCachedTracks = false
    var invokedGetCachedTracksCount = 0
    var stubbedGetCachedTracksResult: [Track]! = []

    func getCachedTracks() -> [Track] {
        invokedGetCachedTracks = true
        invokedGetCachedTracksCount += 1
        return stubbedGetCachedTracksResult
    }
}
