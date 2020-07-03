//
//  ProdcutUseCase.swift
//  ML Test
//
//  Created by Emiliano on 6/29/20.
//

import Foundation
import Combine
import UIKit.UIImage

protocol ProductUseCaseType {
    ///Retorna los productos para una búsqueda específica
    func searchProduct(name: String) -> AnyPublisher<Result<[Product], Error>, Never>
    ///Se encarga de cargar la imagen dado un producto
    func loadImage(product: Product) -> AnyPublisher<UIImage?, Never>
}

final class ProductUseCase: ProductUseCaseType {
    private let networkService: NetworkServiceType
    private let imageLoaderService: ImageRequestServiceType
    
    init(networkService: NetworkServiceType, imageLoaderService: ImageRequestServiceType) {
        self.networkService = networkService
        self.imageLoaderService = imageLoaderService
    }
    
    func searchProduct(name: String) -> AnyPublisher<Result<[Product], Error>, Never> {
        return networkService
            .load(resource: Resource<Products>.products(query: name))
            .map{ result -> Result<[Product], Error> in
                switch result {
                
                case .success(let products): return .success(products.items ?? [Product]())
                case .failure(let error): return .failure(error)
                }
            }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func loadImage(product: Product) -> AnyPublisher<UIImage?, Never> {
        return Deferred { return Just(product.thumbnail)}
            .flatMap({[unowned self] image -> AnyPublisher<UIImage?, Never> in
                guard let image = product.thumbnail,
                      let imageUrl = URL(string: image) else { return Just(nil).eraseToAnyPublisher() }
                let url = imageUrl
                return self.imageLoaderService.loadImage(url: url)
            })
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .share()
            .eraseToAnyPublisher()
    }
}
