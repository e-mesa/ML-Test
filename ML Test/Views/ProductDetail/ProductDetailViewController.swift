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
    private var cancellable: AnyCancellable?
    private var cancellables: [AnyCancellable] = []
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet private var conditionLabel: UILabel!
    @IBOutlet private var freeShippingLabel: UILabel!


    private let viewModel: ProductViewModel
    private let appear = PassthroughSubject<Void, Never>()

    
    init(viewModel: ProductViewModel) {
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

    private func show(_ product: ProductViewModel) {
        titleLabel.text = viewModel.title
        priceLabel.text = "$\(viewModel.price.formattedDecimalString())"
        conditionLabel.text = viewModel.condition == .new ? "Nuevo" : "Usado"
        freeShippingLabel.isHidden = !viewModel.freeShipping
        viewModel.image.sink { [weak self] image in
            self?.productImage.image = image
            self?.cancellables.removeAll()
        }.store(in: &cancellables)
    }
}

