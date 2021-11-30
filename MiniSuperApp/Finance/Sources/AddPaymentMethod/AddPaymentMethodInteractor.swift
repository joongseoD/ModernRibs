//
//  AddPaymentMethodInteractor.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/11/07.
//

import ModernRIBs
import Combine
import FinanceEntity
import FinanceRepository

protocol AddPaymentMethodRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddPaymentMethodPresentable: Presentable {
    var listener: AddPaymentMethodPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol AddPaymentMethodListener: AnyObject {
    func addPaymentMethodDidTapClose()
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod)
}

public protocol AddPaymentMethodInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class AddPaymentMethodInteractor: PresentableInteractor<AddPaymentMethodPresentable>, AddPaymentMethodInteractable, AddPaymentMethodPresentableListener {

    weak var router: AddPaymentMethodRouting?
    weak var listener: AddPaymentMethodListener?

    private let dependency: AddPaymentMethodInteractorDependency
    private var cancellable: Set<AnyCancellable>
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: AddPaymentMethodPresentable,
         dependency: AddPaymentMethodInteractorDependency) {
        self.dependency = dependency
        self.cancellable = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapClose() {
        listener?.addPaymentMethodDidTapClose()
    }
    
    func didTapConfirm(with number: String, cvc: String, expiry: String) {
        let info = AddPaymentMethodInfo(number: number, cvc: cvc, expiration: expiry)
        dependency.cardOnFileRepository.addCard(info: info)
            .sink(receiveCompletion: { _ in }) { [weak self] method in
                self?.listener?.addPaymentMethodDidAddCard(paymentMethod: method)
            }
            .store(in: &cancellable)
            

    }
}
