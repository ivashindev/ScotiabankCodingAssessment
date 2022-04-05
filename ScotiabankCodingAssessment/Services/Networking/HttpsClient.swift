//
//  HttpsClient.swift
//  ScotiabankCodingAssessment
//
//  Created by Dmitry Ivashin on 04.04.2022.
//

import Foundation
import Combine

protocol HTTPSClient {
    func request(url: URL) -> AnyPublisher<Data, Error>
}

enum Endpoint {
    static let base = "https://jsonplaceholder.typicode.com/"
    static let photos = "photos/"
}

class RestRequestHandler: HTTPSClient {
    func request(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .tryMap {
                if let httpResponse = $1 as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    throw URLError(URLError.Code(rawValue: httpResponse.statusCode))
                }
                
                guard $0.count > 0 else { throw URLError(.zeroByteResource) }
                return $0
                
            }.eraseToAnyPublisher()
    }
}
