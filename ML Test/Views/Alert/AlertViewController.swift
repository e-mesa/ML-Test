//
//  AlertViewController.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit

class AlertViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = AccessibilityIdentifiers.someId
    }

    func showStartSearch() {
        render(viewModel: AlertViewModel.startSearch)
    }

    func showNoResults() {
        render(viewModel: AlertViewModel.noResults)
    }

    func showDataLoadingError() {
        render(viewModel: AlertViewModel.dataLoadingError)
    }

    fileprivate func render(viewModel: AlertViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        imageView.image = UIImage(named: viewModel.image ?? "search_icon")
    }
}
