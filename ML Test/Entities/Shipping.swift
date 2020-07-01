//
//  Shipping.swift
//  ML Test
//
//  Created by Emiliano on 6/30/20.
//

import Foundation

struct Shipping: Decodable {
    let freeShipping: Bool?
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
}
