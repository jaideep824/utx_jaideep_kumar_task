//
//  CryptoTableViewCell.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Foundation
import UIKit

class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"
    
    // MARK: - Views
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var cryptoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
        return imageView
    }()
    
    private lazy var newTagImageView: UIImageView = {
        let imageView = UIImageView(image: .newCoinTag)
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Variables
    static let contentInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    private var crypto: Crypto?
    
    
    // MARK: - Initialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Exposed APIs
    func refresh(with crypto: Crypto?) {
        self.crypto = crypto
        showData()
    }
}

private extension CryptoTableViewCell {
    func setupUI() {
        addSubviews()
        addConstraints()
        showData()
    }
    
    func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(newTagImageView)
        contentView.addSubview(cryptoImageView)
    }
    
    func addConstraints() {
        nameLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, right: cryptoImageView.leftAnchor, topConstant: Self.contentInsets.top, leftConstant: Self.contentInsets.left)
        symbolLabel.anchor(nameLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: cryptoImageView.leftAnchor, topConstant: 6, leftConstant: Self.contentInsets.left, bottomConstant: Self.contentInsets.bottom)
        cryptoImageView.anchor(right: contentView.rightAnchor, rightConstant: Self.contentInsets.right, widthConstant: 40, heightConstant: 40)
        cryptoImageView.anchorCenterYToSuperview()
        newTagImageView.anchor(contentView.topAnchor, right: contentView.rightAnchor, widthConstant: 30, heightConstant: 30)
    }
    
    func showData() {
        self.cryptoImageView.isHidden = false
        self.nameLabel.text = crypto?.name ?? ""
        self.symbolLabel.text = crypto?.symbol ?? ""
        self.newTagImageView.isHidden = !(crypto?.isNew ?? false)
        
        if crypto?.isActive ?? false {
            self.cryptoImageView.image = crypto?.cryptoType == .coin ? .activeCoin : .activeToken.withRenderingMode(.alwaysTemplate)
        } else {
            self.cryptoImageView.image = .inactiveCoin.withRenderingMode(.alwaysTemplate)
        }
    }
}
