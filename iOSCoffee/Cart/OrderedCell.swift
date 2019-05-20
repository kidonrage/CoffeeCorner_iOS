//
//  OrderedCell.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 18/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

class OrderedCell: ProductBaseCell {
    
    let quantityContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    let decreaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.setTitleColor(.flatCoffee, for: .normal)
        button.layer.borderColor = UIColor.flatCoffee.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.zPosition = 2
        return button
    }()
    let increaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.flatCoffee, for: .normal)
        button.layer.borderColor = UIColor.flatCoffee.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        return button
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    var cellProduct: OrderedProduct?
    weak var delegate: OrderedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @objc func addProduct(_ sender: UIButton) {
        if let product = cellProduct {
            delegate?.didAddProduct(product)
        }
    }
    
    @objc func removeProduct(_ sender: UIButton) {
        if let product = cellProduct {
            delegate?.didRemoveProduct(product)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(quantityContainer)
        quantityContainer.addSubview(decreaseButton)
        quantityContainer.addSubview(increaseButton)
        quantityContainer.addSubview(quantityLabel)
        contentView.addSubview(priceLabel)
        
        increaseButton.addTarget(self, action: #selector(addProduct(_:)), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(removeProduct(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            quantityContainer.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            quantityContainer.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            quantityContainer.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 15),
            quantityContainer.widthAnchor.constraint(equalToConstant: (contentView.frame.width - productImage.frame.width) / 2),
            
            decreaseButton.heightAnchor.constraint(equalToConstant: 25),
            decreaseButton.widthAnchor.constraint(equalToConstant: 25),
            decreaseButton.leftAnchor.constraint(equalTo: quantityContainer.leftAnchor),
            decreaseButton.centerYAnchor.constraint(equalTo: quantityContainer.centerYAnchor),
            
            quantityLabel.leftAnchor.constraint(equalTo: decreaseButton.rightAnchor, constant: 8),
            quantityLabel.centerYAnchor.constraint(equalTo: quantityContainer.centerYAnchor),
            
            increaseButton.heightAnchor.constraint(equalToConstant: 25),
            increaseButton.widthAnchor.constraint(equalToConstant: 25),
            increaseButton.leftAnchor.constraint(equalTo: quantityLabel.rightAnchor, constant: 8),
            increaseButton.centerYAnchor.constraint(equalTo: quantityContainer.centerYAnchor),
            
            priceLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            priceLabel.topAnchor.constraint(equalTo: quantityContainer.topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol OrderedCellDelegate: AnyObject  {
    func didAddProduct(_ product: OrderedProduct)
    func didRemoveProduct(_ product: OrderedProduct)
}
