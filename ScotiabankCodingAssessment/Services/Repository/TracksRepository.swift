//
//  TracksRepository.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import Foundation
import Combine

protocol TracksRepository {
    @discardableResult
    func fetchTracks() -> AnyPublisher<[Track], Error>
    func getCachedTracks() -> [Track]
}

class TracksFetchService: TracksRepository {
    
    private let httpsClient: HTTPSClient
    private let database: Database
    
    init(httpsClient: HTTPSClient, database: Database) {
        self.httpsClient = httpsClient
        self.database = database
    }
    
    @discardableResult
    func fetchTracks() -> AnyPublisher<[Track], Error> {
        let url = URL(string: Endpoint.base + Endpoint.photos)!
        let decoder = JSONDecoder()
        
        return httpsClient
            .request(url: url)
            .tryMap {
                let tracks = try decoder.decode([Track].self, from: $0)
                return try self.saveTracksIfNeeded(tracks)
            }.eraseToAnyPublisher()
    }
    
    func getCachedTracks() -> [Track] {
        do {
            return try self.database
                .getTracks()
                .map { $0.toTrack() }
        } catch {
            return []
        }
    }
    
    private func saveTracksIfNeeded(_ tracks: [Track]) throws ->  [Track] {
        let currentTracksSnapshot = getCachedTracks()
        /// Updates DB only if latest data fetched differs from already saved
        if tracks != currentTracksSnapshot {
            /// Operating on data snapshots requires to delete stale data first
            try database.clear()
            let trackEntities = tracks.map { $0.toTrackEntity() }
            try database.setTracks(trackEntities)
        }
        return tracks
    }
}
