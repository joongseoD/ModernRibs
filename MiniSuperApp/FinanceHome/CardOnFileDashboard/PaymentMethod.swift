//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/10/26.
//

import Foundation

struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
