//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/12/09.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
