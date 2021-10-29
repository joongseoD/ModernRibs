//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/10/26.
//

import Foundation

protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepositoryImp: CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> {
        return paymentMethodSubject
    }
    private let paymentMethodSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "1", name: "신한카드", digits: "0937", color: "#f23338ff", isPrimary: false),
        PaymentMethod(id: "2", name: "현대카드", digits: "8121", color: "#78c5f5ff", isPrimary: false),
        PaymentMethod(id: "3", name: "국민은행", digits: "2812", color: "#65c466ff", isPrimary: false),
        PaymentMethod(id: "4", name: "카카오은행", digits: "8751", color: "#ffcc00ff", isPrimary: false),
    ])
}
