//
//  ProductSearchViewController.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit
import Combine

class ProductSearchViewController : UIViewController {
    private let viewModel: ProductSearchViewModelType
    @IBOutlet private var loadingView: UIView!
    @IBOutlet private var tableView: UITableView!
    private lazy var alertViewController = AlertViewController(nibName: nil, bundle: nil)
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifiers.someId
        return searchController
    }()

    init(viewModel: ProductSearchViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Fatal Error")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //bind(to: viewModel)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func configureUI() {
        definesPresentationContext = true
        title = NSLocalizedString("Productos", comment: "Productos")
        view.accessibilityIdentifier = AccessibilityIdentifiers.someId

        tableView.accessibilityIdentifier = AccessibilityIdentifiers.someId
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellClass: ProductTableViewCell.self)
        //tableView.dataSource = dataSource

        navigationItem.searchController = self.searchController
        searchController.isActive = true
        add(alertViewController)
        alertViewController.showStartSearch()
    }

    private func bind(to viewModel: ProductSearchViewModelType) {
    }

    private func render(_ state: ProductSearchViewState) {
        switch state {
        case .someState:
            break
        }
    }
}

fileprivate extension ProductSearchViewController {
    enum Section: CaseIterable {
        case products
    }
}

extension ProductSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
}

extension ProductSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

