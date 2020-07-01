//
//  ProductViewModel.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import Foundation
import Combine
import UIKit.UIImage

struct ProductViewModel: Hashable {
    
    let id: String
    let title: String
    let price: Double
    let condition: ProductCondition
    let freeShipping: Bool
    let image: AnyPublisher<UIImage?, Never>
    
    static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
