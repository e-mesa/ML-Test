//
//  ServiceProvider.swift
//  ML Test
//
//  Created by Emiliano on 6/29/20.
//

import Foundation

class ServicesProvider {
    let network: NetworkServiceType
    let imageLoader: ImageRequestServiceType

    static func defaultProvider() -> ServicesProvider {
        let network = NetworkService()
        let imageLoader = ImageRequestService()
        return ServicesProvider(network: network, imageLoader: imageLoader)
    }

    init(network: NetworkServiceType, imageLoader: ImageRequestServiceType) {
        self.network = network
        self.imageLoader = imageLoader
    }
}
