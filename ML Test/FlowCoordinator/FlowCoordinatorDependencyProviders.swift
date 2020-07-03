//
//  FlowCoordinatorDependencyProviders.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit
/// Maneja las dependencias externas
protocol ApplicationFlowCoordinatorDependencyProvider: class {
    /// Crea el root VC
    func rootViewController() -> UINavigationController
}

protocol ProductSearchFlowCoordinatorDependencyProvider: class {
    /// Crea el UIViewController para la búsqueda de productos
    func productSearchController(navigator: ProductSearchNavigator) -> UIViewController

    // Crea el UIViewController relacionado al detalle de los productos
    func productDetailController(_ productViewModel: ProductViewModel) -> UIViewController
}



