//
//  ApplicationComponentsFactory.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit

/// ApplicationComponentsFactory se encarga de crear componentes de la aplicación y manejar las dependencias entre ellos
final class ApplicationComponentsFactory {
    
}

extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
    func rootViewController() -> UINavigationController {
        return UINavigationController()
    }
    
}

extension ApplicationComponentsFactory: ProductSearchFlowCoordinatorDependencyProvider {
    func productSearchController(navigator: ProductSearchNavigator) -> UIViewController {
        let viewModel = ProductSearchViewModel()
        return ProductSearchViewController(viewModel: viewModel)
    }
    
    func productDetailController(_ productId: Int) -> UIViewController {
        return UINavigationController()
    }
    
    
}
