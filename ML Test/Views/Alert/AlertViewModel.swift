//
//  AlertViewModel.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import Foundation

struct AlertViewModel {
    let title: String
    let description: String?
    let image: String?

    static var startSearch: AlertViewModel {
        let title = NSLocalizedString("Comienza tu búsqueda", comment: "Buscá tu producto")
        let imageName = "search_icon"
        return AlertViewModel(title: title, description: nil, image: imageName)
    }

    static var dataLoadingError: AlertViewModel {
        let title = NSLocalizedString("Problema al cargar los datos", comment: "Problema al cargar los datos")
        let description = NSLocalizedString("Inténtalo de nuevo", comment: "Inténtalo de nuevo")
        let imageName = "search_icon"
        return AlertViewModel(title: title, description: description, image: imageName)
    }

    
    static var noResults: AlertViewModel {
        let title = NSLocalizedString("No se encontraron productos", comment: "No se ecnontraron productos")
        let description = NSLocalizedString("Intentá de nuevo", comment: "Intentá de nuevo")
        let imageName = "search_icon_fail"
        return AlertViewModel(title: title, description: description, image: imageName)
    }
}
