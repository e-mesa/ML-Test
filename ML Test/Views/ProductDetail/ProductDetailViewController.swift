//
//  ProductDetailViewController.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit
import Combine

class ProductDetailViewController: UIViewController {
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var productImage: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var price: UILabel!
    @IBOutlet private var details: UILabel!

    private let viewModel: ProductDetailViewModelType
    private var cancellables: [AnyCancellable] = []
    private let appear = PassthroughSubject<Void, Never>()

    init(viewModel: ProductDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Fatal error")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = AccessibilityIdentifiers.someId
        bind(to: viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appear.send(())
    }

    private func bind(to viewModel: ProductDetailViewModelType) {
        
    }

    private func render(_ state: ProductDetailViewState) {
        switch state {
        case .someState:
            break
        }
    }

    private func show(_ product: ProductViewModel) {
        name.text = product.name
        price.text = String(product.price)
        details.text = product.description
    }
}

