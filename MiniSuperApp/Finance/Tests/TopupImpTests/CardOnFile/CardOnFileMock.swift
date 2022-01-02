//
//  File.swift
//  
//
//  Created by Damor on 2021/12/30.
//

import Foundation
@testable import TopupImp
import RIBsTestSupport
import FinanceEntity

final class CardOnFileBuildableMock: CardOnFileBuildable {
    
    var buildHandler: ((_ listener: CardOnFileListener) -> CardOnFileRouting)?
    
    var buildCallCount = 0
    var buildPaymentMethod: [PaymentMethod]?
    func build(withListener listener: CardOnFileListener, paymentMethods: [PaymentMethod]) -> CardOnFileRouting {
        buildCallCount += 1
        buildPaymentMethod = paymentMethods
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class CardOnFileRoutingMock: ViewableRoutingMock, CardOnFileRouting {
    
}
