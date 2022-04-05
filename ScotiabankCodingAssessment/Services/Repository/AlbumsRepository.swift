//
//  AlbumsRepository.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import Foundation
import Combine

protocol AlbumsRepository {
    @discardableResult
    func fetchAlbums() -> AnyPublisher<[Album], Error>
    func getCachedAlbums() -> [Album]
}

class AlbumsFetchService: AlbumsRepository {
    
    private let httpsClient: HTTPSClient
    private let database: Database
    
    init(httpsClient: HTTPSClient, database: Database) {
        self.httpsClient = httpsClient
        self.database = database
    }
    
    @discardableResult
    func fetchAlbums() -> AnyPublisher<[Album], Error> {
        let url = URL(string: Endpoint.base + Endpoint.photos)!
        let decoder = JSONDecoder()
        
        return httpsClient
            .request(url: url)
            .tryMap {
                let albumItems = try decoder.decode([Album].self, from: $0)
                return try self.saveAlbumsIfNeeded(albumItems)
            }.eraseToAnyPublisher()
    }
    
    func getCachedAlbums() -> [Album] {
        do {
            return try self.database
                .getAlbumItems()
                .map { $0.toAlbum() }
        } catch {
            return []
        }
    }
    
    private func saveAlbumsIfNeeded(_ albumItems: [Album]) throws ->  [Album] {
        let currentAlbumsSnapshot = getCachedAlbums()
        if albumItems != currentAlbumsSnapshot {
            try database.clear()
            let albumItemEntities = albumItems.map { $0.toAlbumItemEntity() }
            try database.setAlbumItems(albumItemEntities)
        }
        return albumItems
    }
}
