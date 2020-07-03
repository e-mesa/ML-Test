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
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet private var conditionLabel: UILabel!
    @IBOutlet private var freeShippingLabel: UILabel!


    private let viewModel: ProductViewModel
    private var cancellables: [AnyCancellable] = []
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
        cancellable = viewModel.image.sink { [unowned self] image in self.showImage(image: image) }
    }
    
    private func showImage(image: UIImage?) {
        UIView.transition(with: self.productImage,
        duration: 1,
        options: [.beginFromCurrentState, .transitionCurlDown],
        animations: { [weak self] in
            self?.productImage.image = image
        })
    }
}

