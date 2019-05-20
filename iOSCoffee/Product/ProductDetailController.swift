//
//  ProductDetailController.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 17/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

class ProductDetailController: UIViewController{
    
    var product: Product?
    
    var delegate: ProductDetailControllerDelegate?
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.zPosition = 1
        button.tintColor = .darkGray
        button.setImage( UIImage(named: "expand-arrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    let cartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.zPosition = 1
        button.tintColor = .darkGray
        button.setImage( UIImage(named: "shopping_cart_loaded")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    let productDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        return label
    }()
    let sizeTypeControl: UISegmentedControl = {
        let sizes = [
            ProductSize.standard.rawValue,
            ProductSize.big.rawValue
        ]
        let sc = UISegmentedControl(items: sizes)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.tintColor = .flatCoffee
        sc.addTarget(self, action: #selector(sizeChanged), for: .valueChanged)
        let font = UIFont.boldSystemFont(ofSize: 18)
        sc.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        return sc
    }()
    let orderButtonContainer = OrderButtonContainer()
    
    deinit {
        print("Moving from memory...")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        title = product?.name
        
        view.backgroundColor = .white
        
        setupUI()
        
        if let selectedProduct = product {
            if let testimage = UIImage(named: selectedProduct.imageName) {
               productImageView.image = testimage.crop(rect: CGRect(x: 0, y: testimage.size.height / 2, width: testimage.size.width  , height: testimage.size.height / 2))
            }
            productNameLabel.text = selectedProduct.name
            productDescLabel.text = selectedProduct.description
            orderButtonContainer.orderButton.setTitle("Order for \(selectedProduct.usdPrice)$", for: .normal)
        }
        
        orderButtonContainer.orderButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func addToCart() {
        guard let selectedProduct = self.product else {return}
        var selectedSize: ProductSize
        if sizeTypeControl.titleForSegment(at: sizeTypeControl.selectedSegmentIndex) == ProductSize.standard.rawValue {
            selectedSize = .standard
        } else {
            selectedSize = .big
        }
        Cart.shared.addToCart(ordered: OrderedProduct(product: selectedProduct, size: selectedSize, quantity: 1))
        animatePopup(productName: selectedProduct.name, size: selectedSize.rawValue)
    }
    
    func animatePopup(productName: String, size: String) {
        let newPopup = TopPopupView(productName: productName, size: size)
        view.addSubview(newPopup)
        
        newPopup.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        newPopup.rightAnchor.constraint(equalTo: cartButton.leftAnchor, constant: -8).isActive = true
        newPopup.centerYAnchor.constraint(equalTo: cartButton.centerYAnchor).isActive = true
        
        newPopup.transform = CGAffineTransform(translationX: 0, y: -90)
        
        UIView.animate(withDuration: 0.5, animations: {
            newPopup.isHidden = false
            newPopup.transform = .identity
        }) { (finished) in
            UIView.animate(withDuration: 0.5, delay: 1, animations: {
                newPopup.transform = CGAffineTransform(translationX: 0, y: -90)
            }, completion: { (finished) in
                newPopup.isHidden = true
                newPopup.removeFromSuperview()
            })
        }
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func cartButtonTapped() {
        delegate?.didMoveToCart()
        dismiss(animated: true)
    }
    
    @objc func sizeChanged() {
        guard let selectedProduct = self.product else {return}
        if sizeTypeControl.titleForSegment(at: sizeTypeControl.selectedSegmentIndex) == ProductSize.standard.rawValue {
            orderButtonContainer.orderButton.setTitle("Order for \(selectedProduct.usdPrice)$", for: .normal)
        } else {
            orderButtonContainer.orderButton.setTitle("Order for \(selectedProduct.usdPrice + selectedProduct.usdPrice / 3)$", for: .normal)
        }
    }

    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(cartButton)
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productDescLabel)
        view.addSubview(sizeTypeControl)
        view.addSubview(orderButtonContainer)
        
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: productImageView.image?.size.height ?? 200),
            productImageView.topAnchor.constraint(equalTo: view.topAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 8),
            backButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            cartButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 8),
            cartButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            cartButton.widthAnchor.constraint(equalToConstant: 50),
            cartButton.heightAnchor.constraint(equalToConstant: 50),
            
            productNameLabel.bottomAnchor.constraint(equalTo: productDescLabel.topAnchor, constant: -10),
            productNameLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            productNameLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            
            productDescLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            productDescLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            productDescLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            sizeTypeControl.heightAnchor.constraint(equalToConstant: 35),
            sizeTypeControl.topAnchor.constraint(equalTo: productDescLabel.bottomAnchor, constant: 15),
            sizeTypeControl.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            sizeTypeControl.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            
            orderButtonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderButtonContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 2),
            orderButtonContainer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 1),
        ])
    }

}

protocol ProductDetailControllerDelegate {
    func didMoveToCart()
}
