//
//  File.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Combine
@testable import ScotiabankCodingAssessment

class AlbumsRepositorySpy: AlbumsRepository {

    var invokedFetchAlbums = false
    var invokedFetchAlbumsCount = 0
    var stubbedFetchAlbumsResult: AnyPublisher<[Album], Error>!

    func fetchAlbums() -> AnyPublisher<[Album], Error> {
        invokedFetchAlbums = true
        invokedFetchAlbumsCount += 1
        return stubbedFetchAlbumsResult
    }

    var invokedGetCachedAlbums = false
    var invokedGetCachedAlbumsCount = 0
    var stubbedGetCachedAlbumsResult: [Album]! = []

    func getCachedAlbums() -> [Album] {
        invokedGetCachedAlbums = true
        invokedGetCachedAlbumsCount += 1
        return stubbedGetCachedAlbumsResult
    }
}
