//
//  AppManager.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    
    let tracksRepository: TracksRepository
    
    private convenience init() {
        let httpsClient = RestRequestService()
        let database = RealmDatabase()
        let tracksRepository = TracksFetchService(httpsClient: httpsClient,
                                                  database: database)
        
        self.init(tracksRepository: tracksRepository)
    }
    
    private init(tracksRepository: TracksRepository) {
        self.tracksRepository = tracksRepository
    }
}
