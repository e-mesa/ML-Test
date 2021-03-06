//
//  ProductTableViewCell.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit
import Combine

class ProductTableViewCell: UITableViewCell, ReusableView, NibProtocol {
    @IBOutlet private var name: UILabel!
    @IBOutlet private var price: UILabel!
    @IBOutlet private var productImage: UIImageView!
    private var cancellable: AnyCancellable?
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var freeShipping: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }

    func bind(to viewModel: ProductViewModel) {
        cancelImageLoading()
        name.text = viewModel.title
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        price.text = "$\(viewModel.price.formattedDecimalString())"
        bottomLabelsSetup(condition: viewModel.condition, freeShipping: viewModel.freeShipping)
        cancellable = viewModel.image.sink { [unowned self] image in self.showImage(image: image) }
    }

    private func showImage(image: UIImage?) {
        cancelImageLoading()
        UIView.transition(with: self.productImage,
        duration: 0.2,
        options: [.curveEaseOut, .transitionCrossDissolve],
        animations: {
            self.productImage.image = image
        })
    }

    private func bottomLabelsSetup(condition: ProductCondition, freeShipping: Bool) {
        self.condition.text = condition == .new ? "Nuevo" : "Usado"
        self.freeShipping.isHidden = !freeShipping
    }
    
    private func cancelImageLoading() {
        productImage.image = nil
        cancellable?.cancel()
    }
}
