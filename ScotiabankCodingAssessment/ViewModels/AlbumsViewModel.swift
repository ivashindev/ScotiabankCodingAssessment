//
//  ContentViewModel.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI
import Combine

protocol ViewModel: ObservableObject {
    var presentationItems: [PresentationItem] { get }
}

class AlbumsViewModel: ViewModel {
    
    @Published var presentationItems: [PresentationItem] = []
    
    private let albumsFetchService: AlbumsRepository
    private(set) var tracksMap: [Int: [PresentationItem]] = [:]
    
    private var disposeBag: Set<AnyCancellable> = []
    
    init(albumsFetchService: AlbumsRepository = AppManager.shared.albumsRepository) {
        self.albumsFetchService = albumsFetchService
        
        albumsFetchService
            .fetchAlbums()
            .replaceError(with: self.albumsFetchService.getCachedAlbums())
            .sink { _ in
                
            } receiveValue: { albums in
                self.handleAlbumItems(albums)
            }
            .store(in: &disposeBag)
    }
    
    func willPresentTracksView(for albumId: Int) -> [PresentationItem]? {
        return tracksMap[albumId]
    }
    
    private func handleAlbumItems(_ items: [Album]) {
        /// Creates hashmap for tracks first since it looks more efficient
        /// Then maps presentationItems for Albums VM from tracks hashmap
        tracksMap = PresentationItemMapper.mapToTracksDictionary(from: items)
        let presentationItems = PresentationItemMapper.mapToPresentationItems(from: self.tracksMap)
        DispatchQueue.main.async {
            self.presentationItems = presentationItems
        }
    }
}
