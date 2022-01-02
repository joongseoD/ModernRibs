//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/12/16.
//

import Foundation
import AppHome
import FinanceHome
import ProfileHome
import FinanceRepository
import ModernRIBs
import TransportHome
import TransportHomeImp
import TopupImp
import Topup
import AddPaymentMethodImp
import AddPaymentMethod
import Network
import NetworkImp
import CombineSchedulers

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency {
    var mainQueue: AnySchedulerOf<DispatchQueue> { .main }
    var cardOnFileRepository: CardOnFileRepository
    var superPayRepository: SuperPayRepository
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        return TransportHomeBuilder(dependency: self)
    }()
    
    lazy var topupBuildable: TopupBuildable = {
        return TopupBuilder(dependency: self)
    }()
    
    lazy var addPaymentMethodBuildable: AddPaymentMethodBuildable = {
        return AddPaymentMethodBuilder(dependency: self)
    }()
    
    var topupBaseViewController: ViewControllable { rootViewController.topViewControllerable }
    
    private let rootViewController: ViewControllable
    
    init(
        dependency: AppRootDependency,
        rootViewController: ViewControllable
    ) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [SuperAppURLProtocol.self]
        setupURLProtocol()
        
        let network = NetworkImp(session: URLSession(configuration: config))
        
        self.cardOnFileRepository = CardOnFileRepositoryImp(network: network,
                                                            baseURL: BaseURL().financeBaseURL)
        self.cardOnFileRepository.fetch()
        
        self.superPayRepository = SuperPayRepositoryImp(network: network,
                                                        baseURL: BaseURL().financeBaseURL)
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}
