//
//  TracksViewModel.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Foundation

class TracksViewModel: ViewModel {
    
    @Published var presentationItems: [PresentationItem]
    
    init(presentationItems: [PresentationItem]) {
        self.presentationItems = presentationItems
    }
}
