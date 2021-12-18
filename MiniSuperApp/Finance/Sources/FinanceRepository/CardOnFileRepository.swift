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
import Network

public protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
    func fetch()
}

public final class CardOnFileRepositoryImp: CardOnFileRepository {
    
    private let network: Network
    private let baseURL: URL
    private var cancellables: Set<AnyCancellable>
    
    public init(network: Network, baseURL: URL) {
        self.network = network
        self.baseURL = baseURL
        self.cancellables = .init()
    }
    
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> {
        return paymentMethodSubject
    }
    
    private let paymentMethodSubject = CurrentValuePublisher<[PaymentMethod]>([
//        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
//        PaymentMethod(id: "1", name: "신한카드", digits: "0937", color: "#f23338ff", isPrimary: false)
    ])
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let request = AddCardRequest(baseURL: baseURL, info: info)
        
        return network.send(request)
            .map(\.output.card)
            .handleEvents(
                receiveSubscription: nil,
                receiveOutput: { [weak self] method in
                    guard let self = self else { return }
                    self.paymentMethodSubject.send(self.paymentMethodSubject.value + [method])
                },
                receiveCompletion: nil,
                receiveCancel: nil,
                receiveRequest: nil
            )
            .eraseToAnyPublisher()
//
//        let paymentMethod = PaymentMethod(id: "00", name: "New Card", digits: "\(info.number.suffix(4))", color: "", isPrimary: false)
//
//        var new = paymentMethodSubject.value
//        new.append(paymentMethod)
//        paymentMethodSubject.send(new)
//
//        return Just(paymentMethod)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
    }
    
    public func fetch() {
        let request = CardOnFileRequest(baseURL: baseURL)
        
        network.send(request)
            .map(\.output.cards)
            .sink(receiveCompletion: { _ in }) { [weak self] cards in
                self?.paymentMethodSubject.send(cards)
            }
            .store(in: &cancellables)
    }
}
