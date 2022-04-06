//
//  ContentView.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI

struct TracksView: View {
    
    private static let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    private let tracks: [PresentationItem]
    
    init(tracks: [PresentationItem]) {
        self.tracks = tracks
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: TracksView.gridItemLayout) {
                ForEach(tracks, id: \.id) {
                    CellView(presentationItem: $0)
                }
            }.padding()
        }.navigationTitle(Text(Strings.tracks))
    }
}
