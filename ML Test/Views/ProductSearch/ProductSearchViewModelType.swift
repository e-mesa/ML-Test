//
//  ProductSearchViewModelType.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import Foundation
import Combine

protocol ProductSearchViewModelType {
    func transform(input: ProductSearchViewModelInput) -> ProductSearchViewModelOutput
}

typealias ProductSearchViewModelOutput = AnyPublisher<ProductSearchViewState, Never>

///Inputs de la pantalla de búsqueda de producto
struct ProductSearchViewModelInput {
    let appear: AnyPublisher<Void, Never>
    let search: AnyPublisher<String, Never>
    let selection: AnyPublisher<String, Never>
}

///Estados de la pantalla de búsqueda de producto
enum ProductSearchViewState {
    case idle
    case loading
    case success([ProductViewModel])
    case noResults
    case failure(Error)
}

extension ProductSearchViewState: Equatable {
    static func == (lhs: ProductSearchViewState, rhs: ProductSearchViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.success(let lhsProducts), .success(let rhsProducts)): return lhsProducts == rhsProducts
        case (.noResults, .noResults): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}
