//
//  TracksViewModelTests.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import XCTest
@testable import ScotiabankCodingAssessment

class TracksViewModelTests: XCTestCase {

    func testInit() {
        let presentationItems = [
            PresentationItem(id: 0,
                                 title: "Album 0",
                             coverImageURL: URL(string: "https://")),
            PresentationItem(id: 1,
                                 title: "Album 1",
                             coverImageURL: URL(string: "https://"))
        ]
        let tracksViewModel = TracksViewModel(presentationItems: presentationItems)
        
        XCTAssertEqual(tracksViewModel.presentationItems, presentationItems)
    }
}
