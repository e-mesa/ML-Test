//
//  Decodable+Json.swift
//  ML Test
//
//  Created by Emiliano Mesa on 7/1/20.
//

import Foundation

public extension Decodable {
    private static var customDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }

    init?(jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }

        do {
            self = try Self.customDecoder.decode(Self.self, from: data)
        } catch {
            debugPrint("Decodable error \(error)")
            return nil
        }
    }
}
