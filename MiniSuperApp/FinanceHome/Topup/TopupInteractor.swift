//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/11/18.
//

import ModernRIBs

protocol TopupRouting: Routing {
    func cleanupViews()
    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile()
    func detachCardOnFile()
}

protocol TopupListener: AnyObject {
    func topupDidClose()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AddPaymentMethodListener, AdaptivePresentationControllerDelegate {

    weak var router: TopupRouting?
    weak var listener: TopupListener?

    private let dependency: TopupInteractorDependency
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
    
    init(
        dependency: TopupInteractorDependency
    ) {
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        self.dependency = dependency
        super.init()
        self.presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if dependency.cardOnFileRepository.cardOnFile.value.isEmpty {
            //카드 추가 화면
            router?.attachAddPaymentMethod()
        } else {
            //금액 입력 화면
            router?.attachEnterAmount()
        }
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func presentationControllerDidDismiss() {
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        
    }
    
    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        listener?.topupDidClose()
    }
    
    func enterAmountDidTapPaymentMethod() {
        router?.attachCardOnFile()   
    }
    
    func cardOnFileDidTapClose() {
        router?.detachCardOnFile()
    }
}
