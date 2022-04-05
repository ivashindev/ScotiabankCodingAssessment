//
//  ScotiabankCodingAssessmentApp.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import SwiftUI

@main
struct ScotiabankCodingAssessmentApp: App {
    var body: some Scene {
        WindowGroup {
            #if !TEST
            AlbumsView()
            #else
            EmptyView()
            #endif
        }
    }
}
