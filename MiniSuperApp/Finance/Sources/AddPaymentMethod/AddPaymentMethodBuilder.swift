//
//  AddPaymentMethodBuilder.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/11/07.
//

import ModernRIBs
import FinanceRepository
import RIBsUtil

public protocol AddPaymentMethodDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

public final class AddPaymentMethodComponent: Component<AddPaymentMethodDependency>, AddPaymentMethodInteractorDependency {

    public var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol AddPaymentMethodBuildable: Buildable {
    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting
}

public final class AddPaymentMethodBuilder: Builder<AddPaymentMethodDependency>, AddPaymentMethodBuildable {

    public override init(dependency: AddPaymentMethodDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting {
        let component = AddPaymentMethodComponent(dependency: dependency)
        let viewController = AddPaymentMethodViewController(buttonType: closeButtonType)
        let interactor = AddPaymentMethodInteractor(presenter: viewController,
                                                    dependency: component)
        interactor.listener = listener
        return AddPaymentMethodRouter(interactor: interactor, viewController: viewController)
    }
}
