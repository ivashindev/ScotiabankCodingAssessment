//
//  ContentView.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI

struct TracksView: View {
    
    private static let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ObservedObject var tracksViewModel: TracksViewModel
    
    init(tracksViewModel: TracksViewModel) {
        self.tracksViewModel = tracksViewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: TracksView.gridItemLayout) {
                ForEach(tracksViewModel.presentationItems, id: \.self) {
                    CellView(presentationItem: $0)
                }
            }.padding()
        }.navigationTitle(Text(Strings.tracks))
    }
}
