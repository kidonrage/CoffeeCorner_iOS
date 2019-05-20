//
//  ProductBaseCell.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 18/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

class ProductBaseCell: UITableViewCell {

    let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layoutMargins = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.flatCoffee.withAlphaComponent(0.1)
        self.selectedBackgroundView = selectedView
        
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            productImage.heightAnchor.constraint(equalToConstant: 80),
            productImage.widthAnchor.constraint(equalToConstant: 80),
            productImage.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            productImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 15),
            nameLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            
            infoLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 15),
            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            infoLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
