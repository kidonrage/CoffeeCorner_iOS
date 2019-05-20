//
//  ViewController.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 15/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

class ProductsController: UITableViewController {

    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Coffee Corner"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: "productCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func fetchData() {
        if let url = Bundle.main.url(forResource: "coffee", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsonDecoder = JSONDecoder()
                do {
                    products = try jsonDecoder.decode([Product].self, from: data)
                } catch {
                    print("Error fetching coffee from json: \(error)")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        let coffeeType = products[indexPath.row]
        
        cell.productImage.image = UIImage(named: coffeeType.imageName)
        cell.nameLabel.text = coffeeType.name
        cell.infoLabel.text = coffeeType.description
        cell.priceLabel.text = "from $\(coffeeType.usdPrice)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        
        let vc = ProductDetailController()
        vc.delegate = self
        vc.product = product
        
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ProductsController: ProductDetailControllerDelegate {
    func didMoveToCart() {
        tabBarController?.selectedIndex = 1
    }
}
