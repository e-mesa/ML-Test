//
//  ProductSearchViewModel.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import Foundation
import Combine

final class ProductSearchViewModel: ProductSearchViewModelType {
    private weak var navigator: ProductSearchNavigator?
    private let useCase: ProductUseCaseType
    private var cancellables: [AnyCancellable] = []
    
    init(useCase: ProductUseCaseType, navigator: ProductSearchNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: ProductSearchViewModelInput) -> ProductSearchViewModelOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        input.selection
            .sink(receiveValue: { [unowned self] productId in self.navigator?.showProductDetail(productId: productId) })
            .store(in: &cancellables)
        
        let searchInput = input.search
            .debounce(for: .milliseconds(300), scheduler: Scheduler.mainScheduler)
            .removeDuplicates()
        let products = searchInput
            .filter({ !$0.isEmpty })
            .flatMap({[unowned self] query in self.useCase.searchProduct(name: query)})
            .map({ result -> ProductSearchViewState in
                switch result {
                case .success([]): return .noResults
                case .success(let products): return .success(self.viewModels(from: products))
                case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()
        let initialState: ProductSearchViewModelOutput = Just(ProductSearchViewState.idle).eraseToAnyPublisher()
        let emptySearchString: ProductSearchViewModelOutput = searchInput.filter({ $0.isEmpty }).map({ _ in .idle }).eraseToAnyPublisher()
        let idle: ProductSearchViewModelOutput = Publishers.Merge(initialState, emptySearchString).eraseToAnyPublisher()

        return Publishers.Merge(idle, products).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func viewModels(from products: [Product]) -> [ProductViewModel] {
        return products.map({[unowned self] product in
            return ProductSearchViewModelBuilder.viewModel(product: product) {[unowned self] producct in                   self.useCase.loadImage(product: product)
            }
        })
    }
}
