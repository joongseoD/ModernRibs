import ModernRIBs

protocol FinanceHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashboardDependency, CardOnFileDashboardDependency {
    private let balancePublisher: CurrentValuePublisher<Double>
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
    var cardsOnFileRepository: CardOnFileRepository
    
    init(
        dependency: FinanceHomeDependency,
        balance: CurrentValuePublisher<Double>,
        cardOnFileRepository: CardOnFileRepository
    ) {
        self.balancePublisher = balance
        self.cardsOnFileRepository = cardOnFileRepository
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
        let balancePublisher = CurrentValuePublisher<Double>(0)
        let cardOnFileRepository = CardOnFileRepositoryImp()
        
        let component = FinanceHomeComponent(dependency: dependency,
                                             balance: balancePublisher,
                                             cardOnFileRepository: cardOnFileRepository)
        let viewController = FinanceHomeViewController()
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
        let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
        
        return FinanceHomeRouter(
            interactor: interactor,
            viewController: viewController,
            superPayDashboardBuildable: superPayDashboardBuilder,
            cardOnFileDashboardBuildable: cardOnFileDashboardBuilder
        )
    }
}
