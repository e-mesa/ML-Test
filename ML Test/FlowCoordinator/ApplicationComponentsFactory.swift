//
//  ApplicationComponentsFactory.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit

/// ApplicationComponentsFactory se encarga de crear componentes de la aplicación y manejar las dependencias entre ellos
final class ApplicationComponentsFactory {
    private let servicesProvider: ServicesProvider
    fileprivate lazy var userCase: ProductUseCaseType = ProductUseCase(networkService: servicesProvider.network, imageLoaderService: servicesProvider.imageLoader)
    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
    func rootViewController() -> UINavigationController {
        let rootViewController = UINavigationController()
        rootViewController.navigationBar.tintColor = UIColor.gray
        return rootViewController
    }
}

extension ApplicationComponentsFactory: ProductSearchFlowCoordinatorDependencyProvider {
    func productSearchController(navigator: ProductSearchNavigator) -> UIViewController {
        let viewModel = ProductSearchViewModel(useCase: userCase, navigator: navigator)
        return ProductSearchViewController(viewModel: viewModel)
    }
    
    func productDetailController(_ productId: String) -> UIViewController {
        return UINavigationController()
    }
    
    
}
