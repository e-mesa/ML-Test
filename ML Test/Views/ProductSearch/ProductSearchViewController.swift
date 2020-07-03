//
//  ProductSearchViewController.swift
//  ML Test
//
//  Created by Emiliano on 6/28/20.
//

import UIKit
import Combine

class ProductSearchViewController : UIViewController {
    private var cancellables: [AnyCancellable] = []
    private let selection = PassthroughSubject<ProductViewModel, Never>()
    private let search = PassthroughSubject<String, Never>()
    private let appear = PassthroughSubject<Void, Never>()
    private let viewModel: ProductSearchViewModelType
    @IBOutlet private var loadingView: UIView!
    @IBOutlet private var tableView: UITableView!
    private lazy var alertViewController = AlertViewController(nibName: nil, bundle: nil)
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.systemYellow
        searchController.searchBar.delegate = self
        return searchController
    }()
    private lazy var dataSource = makeDataSource()
    
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
        bind(to: viewModel)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func configureUI() {
        definesPresentationContext = true
        title = NSLocalizedString("Productos", comment: "Productos")
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellClass: ProductTableViewCell.self)
        tableView.dataSource = dataSource

        navigationItem.searchController = self.searchController
        searchController.isActive = true
        add(alertViewController)
        alertViewController.showStartSearch()
    }

    private func bind(to viewModel: ProductSearchViewModelType) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        let input = ProductSearchViewModelInput(appear: appear.eraseToAnyPublisher(),
                                               search: search.eraseToAnyPublisher(),
                                               selection: selection.eraseToAnyPublisher())

        let output = viewModel.transform(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
}

extension ProductSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search.send(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search.send("")
    }
}

extension ProductSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let snapshot = dataSource.snapshot()
        selection.send(snapshot.itemIdentifiers[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

// MARK: - UI Update
extension ProductSearchViewController {
    
    enum Section: CaseIterable {
        case products
    }
    
    private func render(_ state: ProductSearchViewState) {
        switch state {
        case .idle:
            alertViewController.view.isHidden = false
            alertViewController.showStartSearch()
            loadingView.isHidden = true
            update(with: [], animate: true)
        case .loading:
            alertViewController.view.isHidden = true
            loadingView.isHidden = false
            update(with: [], animate: true)
        case .noResults:
            alertViewController.view.isHidden = false
            alertViewController.showNoResults()
            loadingView.isHidden = true
            update(with: [], animate: true)
        case .failure:
            alertViewController.view.isHidden = false
            alertViewController.showDataLoadingError()
            loadingView.isHidden = true
            update(with: [], animate: true)
        case .success(let products):
            alertViewController.view.isHidden = true
            loadingView.isHidden = true
            update(with: products, animate: true)
        }
    }
    
    func update(with products: [ProductViewModel], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, ProductViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(products, toSection: .products)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, ProductViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, ProductViewModel in
                guard let cell = tableView.dequeueReusableCell(withClass: ProductTableViewCell.self) else {
                    assertionFailure("Failed to dequeue \(ProductTableViewCell.self)!")
                    return UITableViewCell()
                }
                cell.bind(to: ProductViewModel)
                cell.selectionStyle = .none
                return cell
            }
        )
    }
}

