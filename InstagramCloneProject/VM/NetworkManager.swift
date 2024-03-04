//
//  NetworkManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/29.
//

import Foundation
import Combine

final class NetworkService {

    enum NetworkError: Error {
        case invalidRequest
        case unknownError(message: String)
    }

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }
    func request(request: URLRequest) -> AnyPublisher<Data, NetworkError> {
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidRequest
                }
                return data
            }
            .mapError { error -> NetworkError in
                return .unknownError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    deinit {
        session.invalidateAndCancel()
    }
}
