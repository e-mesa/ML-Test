//
//  ProductViewModel.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import Foundation
import Combine
import UIKit.UIImage

struct ProductViewModel {
    let id: Int
    let name: String
    let price: Double
    let description: String
    let image: AnyPublisher<UIImage?, Never>
}
