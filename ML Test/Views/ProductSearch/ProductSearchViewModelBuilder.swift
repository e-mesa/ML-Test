//
//  ProductSearchViewModelBuilder.swift
//  ML Test
//
//  Created by Emiliano on 6/30/20.
//

import Foundation

import Foundation
import UIKit.UIImage
import Combine

enum ProductCondition {
    case new
    case old
}

struct ProductSearchViewModelBuilder {
    static func viewModel(product: Product,
                          imageLoader: (Product) -> AnyPublisher<UIImage?, Never>) -> ProductViewModel {
        
        let productCondition: ProductCondition  = product.condition == "new" ? .new : .old
        
        return ProductViewModel(id: product.id ?? "",
                                title: product.title ?? "",
                                price: product.price ?? 0,
                                condition: productCondition,
                                freeShipping: product.shipping.freeShipping ?? false,
                                image: imageLoader(product))
    }
}
