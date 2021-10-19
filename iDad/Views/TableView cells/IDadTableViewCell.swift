//
//  IDadTableViewCell.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class IDadTableViewCell: UITableViewCell {
    
    @UsesAutoLayout
    var profileImageView: IDadImageView = {
        let imageView = IDadImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    @UsesAutoLayout
    var quoteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    @UsesAutoLayout
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    private func configureCell() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(quoteLabel)
        contentView.addSubview(nameLabel)
        configureAutoLayoutConstraints()
    }
    
    private func configureAutoLayoutConstraints() {
        let padding: CGFloat = 6
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (padding/2)),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(padding/2)),
            profileImageView.widthAnchor.constraint(equalToConstant: (contentView.bounds.width / 2.1)),
            
            quoteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (padding * 2)),
            quoteLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: (padding * 2)),
            quoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            nameLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: (padding * 3)),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: (padding/2)),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(padding * 3)),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(padding * 2))
        ])
    }
    
    func set(with iDadViewModel: IDadViewModel) {
        nameLabel.text = iDadViewModel.name.prefixedWithLongHyphen()
        quoteLabel.text = iDadViewModel.topQuote?.surroundedWithQuotes()
        if !USE_NETWORK_DATA {
            profileImageView.image = iDadViewModel.profilePicture
        } else if let profilePictureUrl = iDadViewModel.profilePictureUrl {
            profileImageView.imageFromURL(profilePictureUrl)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        quoteLabel.text = nil
        nameLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
