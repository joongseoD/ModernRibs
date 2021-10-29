//
//  Formmater.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/10/24.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
