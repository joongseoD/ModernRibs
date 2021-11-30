//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/10/26.
//

import Foundation
import Combine
import FinanceEntity
import CombineUtil

public protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
}

public final class CardOnFileRepositoryImp: CardOnFileRepository {
    
    public init() {
        
    }
    
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> {
        return paymentMethodSubject
    }
    
    private let paymentMethodSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "1", name: "신한카드", digits: "0937", color: "#f23338ff", isPrimary: false)
    ])
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let paymentMethod = PaymentMethod(id: "00", name: "New Card", digits: "\(info.number.suffix(4))", color: "", isPrimary: false)
        
        var new = paymentMethodSubject.value
        new.append(paymentMethod)
        paymentMethodSubject.send(new)
        
        return Just(paymentMethod)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
