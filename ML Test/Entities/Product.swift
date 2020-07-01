//
//  Product.swift
//  ML Test
//
//  Created by Emiliano on 6/29/20.
//

import Foundation

struct Products: Decodable {
    let items: [Product]?
    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}

struct Product: Decodable {
    let id: String?
    let title: String?
    let price: Double?
    let thumbnail: String?
    let condition: String?
    let shipping: Shipping
}

extension Product: Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


