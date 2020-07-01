//
//  Resource+Product.swift
//  ML Test
//
//  Created by Emiliano on 6/30/20.
//

import Foundation

extension Resource {
    static func products(query: String) -> Resource<Products> {
        let url = MLServiceConstants.baseUrl
        let parameters: [String : CustomStringConvertible] = [
            "q": query
            ]
        return Resource<Products>(url: url, parameters: parameters)
    }
}
