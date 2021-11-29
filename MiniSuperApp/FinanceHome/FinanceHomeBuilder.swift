import ModernRIBs

protocol FinanceHomeDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var superPayRepository: SuperPayRepository { get }
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashboardDependency, CardOnFileDashboardDependency, AddPaymentMethodDependency, AddPaymentMethodInteractorDependency, TopupDependency {

    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
    var balance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
    var topupBaseViewController: ViewControllable
    
    init(
        dependency: FinanceHomeDependency,
        topupBaseViewController: ViewControllable
    ) {
        self.topupBaseViewController = topupBaseViewController
        super.init(dependency: dependency)
    }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
    
    override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
        let viewController = FinanceHomeViewController()
        let cardOnFileRepository = CardOnFileRepositoryImp()
        
        let component = FinanceHomeComponent(dependency: dependency,
                                             topupBaseViewController: viewController)
        
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
        let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
        let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
        let topupBuilder = TopupBuilder(dependency: component)
        
        return FinanceHomeRouter(
            interactor: interactor,
            viewController: viewController,
            superPayDashboardBuildable: superPayDashboardBuilder,
            cardOnFileDashboardBuildable: cardOnFileDashboardBuilder,
            addPaymentMethodBuildable: addPaymentMethodBuilder,
            topupBuildable: topupBuilder
        )
    }
}
