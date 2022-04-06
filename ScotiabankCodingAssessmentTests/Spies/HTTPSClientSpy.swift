//
//  HTTPSClientSpy.swift
//  ScotiabankCodingAssessmentTests
//
//  Created by Dmitry Ivashin on 05.04.2022.
//

import Combine
import Foundation
@testable import ScotiabankCodingAssessment

class HTTPSClientSpy: HTTPSClient {
    
    var invokedRequest = false
    var invokedRequestCount = 0
    var invokedRequestParameters: (url: URL, Void)?
    var invokedRequestParametersList = [(url: URL, Void)]()
    var stubbedRequestResult: AnyPublisher<Data, Error>!
    
    func request(url: URL) -> AnyPublisher<Data, Error> {
        invokedRequest = true
        invokedRequestCount += 1
        invokedRequestParameters = (url, ())
        invokedRequestParametersList.append((url, ()))
        return stubbedRequestResult
    }
}
