//
//  ContentView.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI

struct TracksView: View {
    
    private var gridItemLayout = [GridItem(.fixed(160)), GridItem(.fixed(160))]
    
    @ObservedObject var tracksViewModel: TracksViewModel
    
    init(tracksViewModel: TracksViewModel) {
        self.tracksViewModel = tracksViewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 8) {
                ForEach(tracksViewModel.presentationItems, id: \.self) {
                    CellItem(presentationItem: $0)
                }
            }
        }
    }
}
