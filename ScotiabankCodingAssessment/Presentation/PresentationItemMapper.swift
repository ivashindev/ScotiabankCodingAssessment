//
//  MappingExtensions.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Foundation

struct PresentationItemMapper {
    
    static func mapToAlbumsDictionary(from tracks: [Track]) -> [Int: [PresentationItem]] {
        var tracksMap = tracks.reduce(into: [Int: [PresentationItem]]()) { partialResult, element in
            let item = PresentationItem(id: element.id,
                                        title: element.title,
                                        coverImageURL: URL(string: element.thumbnailUrl))
            if let _ = partialResult[element.albumId] {
                partialResult[element.albumId]?.append(item)
            } else {
                partialResult[element.albumId] = []
                partialResult[element.albumId]!.append(item)
            }
        }
        /// Sorted to start tracks list from the highest id
        tracksMap.keys.forEach { tracksMap[$0]!.sort(by: { $0.id < $1.id } )}
        return tracksMap
    }
    
    static func mapToAlbumPresentationItems(from albumsDictionary: [Int: [PresentationItem]]) -> [PresentationItem] {
        return albumsDictionary.keys.reduce(into: [PresentationItem]()) { partialResult, element in
            
            let title = Strings.albumTitle + " \(element)"
            let coverImageURL = albumsDictionary[element]?.first?.coverImageURL
            
            partialResult.append(PresentationItem(id: element,
                                                  title: title,
                                                  coverImageURL: coverImageURL))
        } /// Sorted to start albums list from the highest id
        .sorted(by: { $0.id < $1.id })
    }
}
