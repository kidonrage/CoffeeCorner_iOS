//
//  TopPopup.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 18/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

class TopPopupView: UIView {
    
    let header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Added to cart!"
        return label
    }()
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    init(productName: String, size: String) {
        super.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        isHidden = true
        layer.zPosition = 1
        clipsToBounds = true
        
        addSubview(header)
        addSubview(infoLabel)
        
        infoLabel.text = "\(size) \(productName)"
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurEffectView, at: 0)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            
            header.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            header.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            header.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            
            infoLabel.topAnchor.constraint(equalTo: header.bottomAnchor),
            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            infoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
