import ModernRIBs
import Topup
import TransportHome

protocol TransportHomeInteractable: Interactable, TopupListener {
    var router: TransportHomeRouting? { get set }
    var listener: TransportHomeListener? { get set }
}

protocol TransportHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TransportHomeRouter: ViewableRouter<TransportHomeInteractable, TransportHomeViewControllable>, TransportHomeRouting {
    
    private let topupBuildable: TopupBuildable
    private var topupRouter: Routing?
    
    init(
        interactor: TransportHomeInteractable,
        viewController: TransportHomeViewControllable,
        topupBuildable: TopupBuildable
    ) {
        self.topupBuildable = topupBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTopup() {
        guard topupRouter == nil else { return }
        let router = topupBuildable.build(withListener: interactor)
        attachChild(router)
        topupRouter = router
    }
    
    func detachTopup() {
        guard let router = topupRouter else { return }
        detachChild(router)
        topupRouter = nil
    }
}
