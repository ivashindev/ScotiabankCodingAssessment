//
//  ContentView.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI

struct CellItem: View {
    
    let presentationItem: PresentationItem
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                AsyncImage(url: presentationItem.coverImageURL)
                    .frame(width: 150, height: 150, alignment: .center)
                    .border(Color.black)
                    .padding(8)
                Text(presentationItem.title)
                    .padding()
            }.border(Color.black)
        }
    }
}
