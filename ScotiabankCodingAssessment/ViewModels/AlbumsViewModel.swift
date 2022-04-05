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
            .sink { _ in
                let cachedAlbums = self.albumsFetchService.getCachedAlbums()
                self.handleAlbumItems(cachedAlbums)
            } receiveValue: { albums in
                self.handleAlbumItems(albums)
            }
            .store(in: &disposeBag)
    }
    
    func willPresentTracksView(for albumId: Int) -> [PresentationItem]? {
        return tracksMap[albumId]
    }
    
    private func handleAlbumItems(_ items: [Album]) {
        tracksMap = PresentationItemMapper.mapToTracksDictionary(from: items)
        tracksMap.keys.forEach { tracksMap[$0]!.sort(by: { $0.id < $1.id } )}
        DispatchQueue.main.async {
            self.presentationItems = PresentationItemMapper
                .mapToPresentationItems(from: self.tracksMap)
                .sorted(by: { $0.id < $1.id })
        }
    }
}
