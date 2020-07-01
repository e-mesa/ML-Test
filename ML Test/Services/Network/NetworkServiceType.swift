//
//  NetworkServiceType.swift
//  ML Test
//
//  Created by Emiliano on 6/29/20.
//

import Foundation
import Combine

///Define los errores del servicio
enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case jsonParsingError(error: Error)
    case dataLoadingError(statusCode: Int, data: Data)
}

protocol NetworkServiceType: AnyObject {
    func load<T: Decodable>(resource: Resource<T>) -> AnyPublisher<Result<T, NetworkError>, Never>
}

