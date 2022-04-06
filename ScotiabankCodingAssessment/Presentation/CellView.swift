//
//  ContentView.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI

struct CellView: View {
    
    private static let padding: Double = 8
    private static let imageWidth: Double = 150
    private static let imageHeight: Double = 150
    private static let borderColor: Color = .black
    
    let presentationItem: PresentationItem
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                CachedAsyncImage(url: presentationItem.coverImageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: CellView.imageWidth,
                       height: CellView.imageHeight,
                       alignment: .center)
                .border(CellView.borderColor)
                Text(presentationItem.title)
            }
            .padding(CellView.padding)
            .border(CellView.borderColor)
        }
    }
}

