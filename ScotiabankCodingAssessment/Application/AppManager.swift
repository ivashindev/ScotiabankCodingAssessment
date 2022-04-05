//
//  AppManager.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    
    let albumsRepository: AlbumsRepository
    
    private convenience init() {
        let httpsClient = RestRequestHandler()
        let database = RealmDatabase()
        let albumsRepository = AlbumsFetchService(httpsClient: httpsClient,
                                                   database: database)
        
        self.init(albumsRepository: albumsRepository)
    }
    
    private init(albumsRepository: AlbumsRepository) {
        self.albumsRepository = albumsRepository
        self.albumsRepository.fetchAlbums()
    }
}
