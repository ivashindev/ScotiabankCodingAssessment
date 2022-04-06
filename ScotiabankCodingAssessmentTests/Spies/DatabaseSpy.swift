//
//  DatabaseSpy.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Foundation
@testable import ScotiabankCodingAssessment

class DatabaseSpy: Database {
    
    var invokedSetAlbumItems = false
    var invokedSetAlbumItemsCount = 0
    var invokedSetAlbumItemsParameters: (items: [AlbumEntity], Void)?
    var invokedSetAlbumItemsParametersList = [(items: [AlbumEntity], Void)]()
    var stubbedSetAlbumItemsError: Error?
    
    func setAlbumItems(_ items: [AlbumEntity]) throws {
        invokedSetAlbumItems = true
        invokedSetAlbumItemsCount += 1
        invokedSetAlbumItemsParameters = (items, ())
        invokedSetAlbumItemsParametersList.append((items, ()))
        if let error = stubbedSetAlbumItemsError {
            throw error
        }
    }
    
    var invokedGetAlbumItems = false
    var invokedGetAlbumItemsCount = 0
    var stubbedGetAlbumItemsError: Error?
    var stubbedGetAlbumItemsResult: [AlbumEntity]! = []
    
    func getAlbumItems() throws -> [AlbumEntity] {
        invokedGetAlbumItems = true
        invokedGetAlbumItemsCount += 1
        if let error = stubbedGetAlbumItemsError {
            throw error
        }
        return stubbedGetAlbumItemsResult
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
