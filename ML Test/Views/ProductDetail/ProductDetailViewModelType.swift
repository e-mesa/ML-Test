//
//  ProductDetailViewModelType.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import Foundation
import Combine

struct ProductDetailViewModelInput {
    ///Se llama cuando aparece por primera vez la vista de detalle
    let appear: AnyPublisher<Void, Never>
}


enum ProductDetailViewState {
    case loading
    case success(ProductViewModel)
    case failure(Error)
}

extension ProductDetailViewState: Equatable {
    static func == (lhs: ProductDetailViewState, rhs: ProductDetailViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success(let lhsProduct), .success(let rhsProduct)): return lhsProduct == rhsProduct
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias ProductDetailViewModelOutput = AnyPublisher<ProductDetailViewState, Never>

protocol ProductDetailViewModelType: class {
    func transform(input: ProductDetailViewModelInput) -> ProductDetailViewModelOutput
}
