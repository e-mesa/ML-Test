//
//  ProductSearchFlowCoordinator.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit

class ProductSearchFlowCoordinator: FlowCoordinator, ProductSearchNavigator {
    fileprivate let rootViewController: UINavigationController
    fileprivate let dependencyProvider: ProductSearchFlowCoordinatorDependencyProvider
    
    func start() {
        let productSearchController = dependencyProvider.productSearchController(navigator: self)
        rootViewController.setViewControllers([productSearchController], animated: false)
    }
    
    init(rootController: UINavigationController, dependencyProvider: ProductSearchFlowCoordinatorDependencyProvider) {
        self.rootViewController = rootController
        self.dependencyProvider = dependencyProvider
        
    }
    
    func showProductDetail(productViewModel: ProductViewModel) {
        let controller = self.dependencyProvider.productDetailController(productViewModel)
        self.rootViewController.pushViewController(controller, animated: true)
    }
}
