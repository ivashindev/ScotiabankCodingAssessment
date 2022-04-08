//
//  ContentViewModel.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI
import Combine

class AlbumsViewModel: ObservableObject {
    
    @Published var presentationItems: [PresentationItem] = []
    
    private let tracksFetchService: TracksRepository
    private(set) var albumsMap: [Int: [PresentationItem]] = [:]
    
    private var disposeBag: Set<AnyCancellable> = []
    
    init(tracksFetchService: TracksRepository = AppManager.shared.tracksRepository) {
        self.tracksFetchService = tracksFetchService
        
        tracksFetchService
            .fetchTracks()
            .replaceError(with: self.tracksFetchService.getCachedTracks())
            .sink { _ in
                
            } receiveValue: { tracks in
                self.handleTrackItems(tracks)
            }
            .store(in: &disposeBag)
    }
    
    func willPresentTracksView(for albumId: Int) -> [PresentationItem]? {
        return albumsMap[albumId]
    }
    
    private func handleTrackItems(_ items: [Track]) {
        /// Creates hashmap for tracks first since it looks more efficient
        /// Then maps presentationItems for Albums VM from tracks hashmap
        albumsMap = PresentationItemMapper.mapToAlbumsDictionary(from: items)
        let presentationItems = PresentationItemMapper.mapToAlbumPresentationItems(from: self.albumsMap)
        DispatchQueue.main.async {
            self.presentationItems = presentationItems
        }
    }
}
