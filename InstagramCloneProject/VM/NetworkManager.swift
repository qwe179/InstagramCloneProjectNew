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
        print("request 가 불렸나요?")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("가드렛실패했고?")
                    throw NetworkError.invalidRequest
                }
                return data
            }
            .mapError { error -> NetworkError in
                print("Error: \(error)")
                if let localizedError = error as? LocalizedError {
                    print("Localized Description: \(localizedError.errorDescription ?? "Unknown Error")")
                }
                return .unknownError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    deinit {
        print("세션 맛탱이감")
        session.invalidateAndCancel()
    }
}
