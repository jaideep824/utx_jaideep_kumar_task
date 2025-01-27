//
//  ChipViewCollectionCell.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import UIKit

class ChipViewCollectionCell: UICollectionViewCell {
    static let identifier = "ChipViewCollectionCell"
    
    // MARK: - Views
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Self.fontSize, weight: .regular)
        return label
    }()
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        return imageView
    }()
    
    // MARK: - Variables
    static let fontSize: CGFloat = 11
    static let imageWidth: CGFloat = 16
    static let contentInsets = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 6)
    private var option: FilterOption?
    private var isFilterSelected: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.addBorder()
        contentView.roundedCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed APIs
    func refresh(with option: FilterOption, isFilterSelected: Bool) {
        self.option = option
        self.isFilterSelected = isFilterSelected
        showData()
    }
}

private extension ChipViewCollectionCell {
    func setupUI() {
        addSubviews()
        addConstraints()
        showData()
        contentView.addBorder()
        contentView.roundedCorners()
    }
    
    func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(checkImageView)
    }
    
    func addConstraints() {
        checkImageView.anchor(nil, left: contentView.leftAnchor, leftConstant: Self.contentInsets.left, widthConstant: Self.imageWidth, heightConstant: Self.imageWidth)
        checkImageView.anchorCenterYToSuperview()
        nameLabel.anchor(nil, left: checkImageView.rightAnchor, right: contentView.rightAnchor, leftConstant: 6, rightConstant: Self.contentInsets.left)
        nameLabel.anchorCenterYToSuperview()
    }
    
    func showData() {
        guard let option, let isFilterSelected else { return }
        nameLabel.text = option.rawValue
        checkImageView.isHidden = isFilterSelected == false
    }
}
