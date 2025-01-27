//
//  CryptoListViewController.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Combine
import UIKit

class CryptoListViewController: UIViewController {
    // MARK: - Views
    private(set) lazy var cryptoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var searchButton: UIBarButtonItem = {
        let action = UIAction(handler: searchButtonTapped)
        let button = UIBarButtonItem(systemItem: .search, primaryAction: action)
        return button
    }()
    
    private lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle.fill"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(filterButtonTapped))
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
        
    // MARK: - Variables
    private var cancellables = Set<AnyCancellable>()
    private(set) var isSearchActive = false
    private var searchBarHeightConstraint: NSLayoutConstraint?
    let viewModel: CryptoListViewModel!
    
    // MARK: - Initialisation
    init(viewModel: CryptoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCryptoList()
    }
}

// MARK: - View Setup
private extension CryptoListViewController {
    func setupUI() {
        addSubviews()
        addConstraints()
        showData()
        cryptoTableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        if (UIApplication.shared.delegate as! AppDelegate).window?.overrideUserInterfaceStyle == .light {
            self.view.backgroundColor = .white
        }
    }
    
    func addSubviews() {
        view.addSubview(cryptoTableView)
        view.addSubview(searchBar)
        navigationItem.rightBarButtonItems = [searchButton, filterButton]
        cryptoTableView.addSubview(refreshControl)
    }
    
    func addConstraints() {
        let topSafeArea = view.safeAreaLayoutGuide.topAnchor
        let bottomSafeArea = view.safeAreaLayoutGuide.bottomAnchor
        
        searchBar.anchor(topSafeArea, left: view.leftAnchor)
        searchBarHeightConstraint = searchBar.heightAnchor.constraint(equalToConstant: 0)
        searchBarHeightConstraint?.isActive = true
        searchBar.anchorCenterXToSuperview()
        cryptoTableView.anchor(searchBar.bottomAnchor, left: view.leftAnchor, bottom: bottomSafeArea)
        cryptoTableView.anchorCenterXToSuperview()
    }
    
    func showData() {
        self.title = "Coin"
    }
}

// MARK: - Utility Functions
private extension CryptoListViewController {
    func fetchCryptoList() {
        viewModel.fetchCyptoList()
        viewModel.cryptoListUpdated
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.refreshControl.endRefreshing()
                self?.cryptoTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func searchButtonTapped(action: UIAction) {
        isSearchActive.toggle()
        UIView.animate(withDuration: 0.2) {[weak self] in
            self?.searchBarHeightConstraint?.constant = (self?.isSearchActive ?? false) ? 50 : 0
            self?.view.layoutIfNeeded()
        } completion: {[weak self] _ in
            guard let self = self else { return }
            if self.isSearchActive {
                DispatchQueue.main.async {
                    self.searchBar.becomeFirstResponder()
                }
            } else {
                DispatchQueue.main.async {
                    self.searchBar.resignFirstResponder()
                }
            }
        }
    }
    
    @objc func filterButtonTapped(action: UIAction) {
        let sheetViewController = FilterViewController(options: FilterOption.allCases, selectedState: viewModel.filterSelectedState)
        sheetViewController.delegate = self
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(sheetViewController, animated: true)
    }
        
    @objc func refreshData() {
        viewModel.fetchCyptoList(refreshFromRemote: true)
    }
}
