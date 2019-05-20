//
//  OrderButtonContainer.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 18/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

class OrderButtonContainer: UIView {
    
    let orderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Place an order for", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .flatCoffee
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.addSubview(orderButton)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            
            orderButton.heightAnchor.constraint(equalToConstant: 40),
            orderButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            orderButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            orderButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

