//
//  URLImageLoader.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/29.
//

import SwiftUI
import Combine
class URLImageLoader: ObservableObject {
    @Published var images: [UIImage?] = []
    private let network = NetworkService(session: URLSession(configuration: .default))
    private var cancellables = Set<AnyCancellable>()

    func fetch(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }

        let urlRequest = RequestBuilder(url: url, body: nil, headers: nil).create()
        guard let request = urlRequest else { return }

        network.request(request: request)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Request completed successfully")
                }
            } receiveValue: { [weak self] data in
                DispatchQueue.main.async {
                    self?.images.append(UIImage(data: data))
                }
            }
            .store(in: &cancellables)
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
