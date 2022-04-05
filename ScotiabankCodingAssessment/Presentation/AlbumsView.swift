//
//  ContentView.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI

struct AlbumsView: View {
    
    private var gridItemLayout = [GridItem(.fixed(160)), GridItem(.fixed(160))]
    
    @ObservedObject var viewModel = AlbumsViewModel()
    
    @State private var current: Int? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItemLayout) {
                    ForEach(viewModel.presentationItems, id: \.self) { item in
                        let tracksViewModel = TracksViewModel(presentationItems: viewModel.tracksMap[item.id]!)
                        ZStack {
                            CellItem(presentationItem: item)
                                .onTapGesture {
                                    current = item.id
                                }
                            NavigationLink("", destination: TracksView(tracksViewModel: tracksViewModel),
                                           tag: item.id, selection: $current)
                        }.padding()
                    }
                }
            }.navigationTitle(Strings.albumsNavigationTitle)
        }
    }
}
