//
//  Data+Json.swift
//  ML Test
//
//  Created by Emiliano Mesa on 7/1/20.
//

import Foundation

public extension Data {
    enum Constant {
        static let jsonKey = "json"
    }

    init(jsonFileName: String, bundle: Bundle = Bundle.main) {
        do {
            if let file = bundle.url(forResource: jsonFileName, withExtension: Constant.jsonKey) {
                try self.init(contentsOf: file)
                return
            }
        } catch {
            print(error.localizedDescription)
        }
        self.init()
    }
}
