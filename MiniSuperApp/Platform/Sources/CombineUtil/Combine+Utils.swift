//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/10/24.
//

import Combine
import CombineExt
import Foundation

public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    public typealias Output = Element
    public typealias Failure = Never
    
    fileprivate let currentValueRelay: CurrentValueRelay<Output>
    
    public var value: Element {
        return currentValueRelay.value
    }
    
    fileprivate init(_ initialValue: Element) {
        currentValueRelay = CurrentValueRelay(initialValue)
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Element == S.Input, Never == S.Failure {
        currentValueRelay.receive(subscriber: subscriber)
    }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    typealias Output = Element
    typealias Failure = Never
    
    public override init(_ initialValue: Element) {
        super.init(initialValue)
    }
    
    public func send(_ value: Element) {
        currentValueRelay.accept(value)
    }
}
