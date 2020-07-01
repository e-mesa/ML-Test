//
//  NetworkService.swift
//  ML Test
//
//  Created by Emiliano on 6/29/20.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceType {
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)) {
        self.session = session
    }

    @discardableResult
    func load<T>(resource: Resource<T>) -> AnyPublisher<Result<T, NetworkError>, Never> {
        guard let request = resource.request else {
            return Just(.failure(NetworkError.invalidRequest)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.invalidRequest }
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }
                guard 200..<300 ~= response.statusCode else {
                    return Fail(error: NetworkError.dataLoadingError(statusCode: response.statusCode, data: data)).eraseToAnyPublisher()
                }
                return Just(data)
                    .mapError { error -> Error in NetworkError.invalidRequest}
                    .print()
                    .eraseToAnyPublisher()
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .print()
        .map { .success($0) }
        .catch ({ error -> AnyPublisher<Result<T, NetworkError>, Never> in
            return Just(.failure(NetworkError.jsonParsingError(error: error))).eraseToAnyPublisher()
        })
        .eraseToAnyPublisher()
    }
}
