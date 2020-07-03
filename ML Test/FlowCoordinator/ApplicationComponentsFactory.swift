//
//  ApplicationComponentsFactory.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit
import Combine

/// ApplicationComponentsFactory se encarga de crear componentes de la aplicación y manejar las dependencias entre ellos
final class ApplicationComponentsFactory {
    private let servicesProvider: ServicesProvider

    fileprivate lazy var useCase: ProductUseCaseType = ProductUseCase(networkService: servicesProvider.network, imageLoaderService: servicesProvider.imageLoader)
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
    func productDetailController(_ productId: String) -> UIViewController {
        //emesa
        let viewModel = ProductDetailViewModel(productId: productId)
        return ProductDetailViewController(viewModel: viewModel)
    }

    func productSearchController(navigator: ProductSearchNavigator) -> UIViewController {
        let viewModel = ProductSearchViewModel(useCase: useCase, navigator: navigator)
        return ProductSearchViewController(viewModel: viewModel)
    }
    
}
