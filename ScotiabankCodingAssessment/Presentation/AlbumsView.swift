//
//  ContentView.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI

struct AlbumsView: View {
    
    private static let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ObservedObject var viewModel = AlbumsViewModel()
    
    @State private var current: Int? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: AlbumsView.gridItemLayout) {
                    ForEach(viewModel.presentationItems, id: \.id) { item in
                        let tracks = viewModel.albumsMap[item.id]!
                        ZStack {
                            CellView(presentationItem: item)
                                .onTapGesture {
                                    current = item.id
                                }
                            NavigationLink("", destination: TracksView(tracks: tracks),
                                           tag: item.id, selection: $current)
                        }
                    }
                }.padding()
            }.navigationTitle(Strings.albumsNavigationTitle)
        }
    }
}

