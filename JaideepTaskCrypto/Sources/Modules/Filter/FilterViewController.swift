//
//  FilterViewController.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import UIKit

class FilterViewController: UIViewController {
    // MARK: - Views
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ChipViewCollectionCell.self, forCellWithReuseIdentifier: ChipViewCollectionCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Variables
    weak var delegate: FilterViewControllerDelegate?
    var options: [FilterOption]
    var selectedState: [FilterOption: Bool]
    let rowHeight: CGFloat = 40
    let itemsInRowCount = 3
    
    // MARK: - Initialisation
    init(options: [FilterOption], selectedState: [FilterOption: Bool]) {
        self.options = options
        self.selectedState = selectedState
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
}

private extension FilterViewController {
    func setupUI() {
        addSubviews()
        addConstraints()
        self.view.backgroundColor = collectionView.backgroundColor
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    func addConstraints() {
        collectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 50, leftConstant: 8, rightConstant: 8)
        view.layoutIfNeeded()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
