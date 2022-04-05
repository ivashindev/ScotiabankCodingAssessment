//
//  MappingExtensions.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Foundation

struct PresentationItemMapper {
    
    static func mapToTracksDictionary(from albums: [Album]) -> [Int: [PresentationItem]] {
        var tracksMap = albums.reduce(into: [Int: [PresentationItem]]()) { partialResult, element in
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
    
        tracksMap.keys.forEach { tracksMap[$0]!.sort(by: { $0.id < $1.id } )}
        return tracksMap
    }
    
    static func mapToPresentationItems(from tracksDictionary: [Int: [PresentationItem]]) -> [PresentationItem] {
        return tracksDictionary.keys.reduce(into: [PresentationItem]()) { partialResult, element in
            
            let title = Strings.albumTitle + " \(element)"
            let coverImageURL = tracksDictionary[element]?.last?.coverImageURL
            
            partialResult.append(PresentationItem(id: element,
                                                  title: title,
                                                  coverImageURL: coverImageURL))
        }.sorted(by: { $0.id < $1.id })
    }
}
