//
//  ProductSearchViewModelType.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import Foundation
import Combine

protocol ProductSearchViewModelType {
    func transform(input: ProductSearchViewModelInput) //-> ProductSearchViewModelOutput
}

typealias ProductSearchViewModelOutput = AnyPublisher<ProductSearchViewState, Never>

///Inputs de la pantalla de búsqueda de producto
struct ProductSearchViewModelInput {
    
}

///Estados de la pantalla de búsqueda de producto
enum ProductSearchViewState {
    case someState
}
