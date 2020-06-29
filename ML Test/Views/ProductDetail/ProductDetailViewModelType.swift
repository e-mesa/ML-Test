//
//  ProductDetailViewModelType.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import Foundation

import Foundation
import Combine

protocol ProductDetailViewModelType {
    func transform(input: ProductSearchViewModelInput) //-> ProductSearchViewModelOutput
}

typealias ProductDetailViewModelOutput = AnyPublisher<ProductSearchViewState, Never>

///Inputs de la pantalla de búsqueda de producto
struct ProductDetailViewModelInput {
    
}

///Estados de la pantalla de búsqueda de producto
enum ProductDetailViewState {
    case someState
}
