//
//  ApplicationFlowCoordinator.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit

class ApplicationFlowCoordinator: FlowCoordinator {
    typealias DependencyProvider =  ApplicationFlowCoordinatorDependencyProvider & ProductSearchFlowCoordinatorDependencyProvider
    private let dependencyProvider: DependencyProvider
    private let window: UIWindow
    private var childCoordinators = [FlowCoordinator]()

    
    init(window: UIWindow, dependencyProvider: DependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let productSearchNavigatorController = UINavigationController()
        productSearchNavigatorController.navigationBar.tintColor = UIColor.black
        window.rootViewController = productSearchNavigatorController
        let productSearchFlowCoordinator = ProductSearchFlowCoordinator(rootController: productSearchNavigatorController, dependencyProvider: dependencyProvider)
        productSearchFlowCoordinator.start()
        self.childCoordinators = [productSearchFlowCoordinator]
    }
}
