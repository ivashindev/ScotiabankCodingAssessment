//
//  DatabaseSpy.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Foundation
@testable import ScotiabankCodingAssessment

class DatabaseSpy: Database {

    var invokedSetTracks = false
    var invokedSetTracksCount = 0
    var invokedSetTracksParameters: (tracks: [TrackEntity], Void)?
    var invokedSetTracksParametersList = [(tracks: [TrackEntity], Void)]()
    var stubbedSetTracksError: Error?

    func setTracks(_ tracks: [TrackEntity]) throws {
        invokedSetTracks = true
        invokedSetTracksCount += 1
        invokedSetTracksParameters = (tracks, ())
        invokedSetTracksParametersList.append((tracks, ()))
        if let error = stubbedSetTracksError {
            throw error
        }
    }

    var invokedGetTracks = false
    var invokedGetTracksCount = 0
    var stubbedGetTracksError: Error?
    var stubbedGetTracksResult: [TrackEntity]! = []

    func getTracks() throws -> [TrackEntity] {
        invokedGetTracks = true
        invokedGetTracksCount += 1
        if let error = stubbedGetTracksError {
            throw error
        }
        return stubbedGetTracksResult
    }

    var invokedClear = false
    var invokedClearCount = 0
    var stubbedClearError: Error?

    func clear() throws {
        invokedClear = true
        invokedClearCount += 1
        if let error = stubbedClearError {
            throw error
        }
    }
}
