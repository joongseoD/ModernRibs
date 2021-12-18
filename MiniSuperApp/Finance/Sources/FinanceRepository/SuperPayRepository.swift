//
//  SuperPayRepository.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/11/29.
//

import Foundation
import Combine
import CombineUtil
import Network

public protocol SuperPayRepository {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    
    func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error>
}

public final class SuperPayRepositoryImp: SuperPayRepository {
    public var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSubject }
    
    private let balanceSubject = CurrentValuePublisher<Double>(0)
    private let bgQueue = DispatchQueue(label: "topup.repository.queue")
    
    public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error> {
        let request = TopupRequest(baseURL: baseURL, amount: amount, paymentMethodID: paymentMethodID)
        return network.send(request)
            .handleEvents(
                receiveSubscription: nil,
                receiveOutput: { [weak self] _ in
                    let newBalance = (self?.balanceSubject.value).map { $0 + amount }
                    newBalance.map { self?.balanceSubject.send($0) }
                },
                receiveCompletion: nil,
                receiveCancel: nil,
                receiveRequest: nil)
            .map { _ in }
            .eraseToAnyPublisher()
        
//        return Future<Void, Error> { [weak self] promise in
//            self?.bgQueue.async {
//                Thread.sleep(forTimeInterval: 2)
//                promise(.success(()))
//                let newBalance = (self?.balanceSubject.value).map { $0 + amount }
//                newBalance.map { self?.balanceSubject.send($0) }
//            }
//        }
//        .eraseToAnyPublisher()
    }
    
    private let network: Network
    private let baseURL: URL
    
    public init(network: Network, baseURL: URL) {
        self.network = network
        self.baseURL = baseURL
    }
    
    
}
