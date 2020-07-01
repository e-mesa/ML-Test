//
//  Double+Formatter.swift
//  ML Test
//
//  Created by Emiliano on 6/30/20.
//

import Foundation

extension Double {
    func formattedDecimalString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
