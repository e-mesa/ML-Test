//
//  ProductDetailViewController.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit
import Combine

class ProductDetailViewController: UIViewController {
    @IBOutlet private var productImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet private var conditionLabel: UILabel!
    @IBOutlet private var freeShipingValue: UILabel!


    private let viewModel: ProductDetailViewModel
    private var cancellables: [AnyCancellable] = []
    private let appear = PassthroughSubject<Void, Never>()

    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Fatal error")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        show(viewModel)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appear.send(())
    }

    private func show(_ product: ProductDetailViewModel) {
        titleLabel.text = viewModel.productId
    }
}

