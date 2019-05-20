//
//  ProductCell.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 17/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

class ProductCell: ProductBaseCell {
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .flatCoffee
        label.layer.borderColor = UIColor.flatCoffee.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 15
        label.textAlignment = .center
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.widthAnchor.constraint(equalToConstant: 90),
            priceLabel.heightAnchor.constraint(equalToConstant: 35),
            priceLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 15),
            priceLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
