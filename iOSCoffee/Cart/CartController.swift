//
//  CartController.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 17/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

class CartController: UITableViewController {
    
    let orderButtonContainer = OrderButtonContainer()
    
    var orderedProducts = [OrderedProduct]() {
        didSet {
            if orderedProducts.count > 0 {
                self.orderButtonContainer.isHidden = false
                self.orderButtonContainer.orderButton.setTitle("Place an order for $\(self.total)", for: .normal)
            } else {
                self.orderButtonContainer.isHidden = true
            }
        }
    }
    var total: Int {
        var temp = 0
        for order in self.orderedProducts {
            temp += order.totalPrice
        }
        return temp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cart"
        
        tableView.register(OrderedCell.self, forCellReuseIdentifier: "orderedCell")
        
        orderButtonContainer.orderButton.addTarget(self, action: #selector(order), for: .touchUpInside)
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        orderedProducts = Cart.shared.getProducts()
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(orderButtonContainer)
        
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            orderButtonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderButtonContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 2),
            orderButtonContainer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 1)
        ])
    }
    
    @objc func order() {
        let ac = UIAlertController(title: "Please Enter your name:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            guard let nameField = ac.textFields?[0] else {return}
            if let name = nameField.text, name != "" {
                self.sendOrder(for: name)
            }
        }))
        present(ac, animated: true)
    }
    
    func sendOrder(for name: String) {
        var productsToOrder = [[String: Int]]()
        
        for product in orderedProducts {
            let productTitle = "\(product.size.rawValue.capitalized) \(product.product.name)"
            productsToOrder.append([productTitle : product.quantity])
        }
        
        let order = Order(products: productsToOrder, buyerName: name, total: self.total)
        let url = URL(string: "http://localhost:8080/api/orders/")!
        
        let encoder = JSONEncoder()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(order)
        
        if let json = try? encoder.encode(order) {
            print(String(data: json, encoding: .utf8)!)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                if (try? decoder.decode(Order.self, from: data)) != nil {
                    self.showAlert(title: "Success!", message: "Your order is already underway", completion: {
                        self.removeOrder()
                    })
                } else {
                    self.showAlert(title: "Oh-oh. Something went wrong!", message: "We couldn't send the order", completion: nil)
                    print("Bad JSON recieved back.")
                }
            }
        }.resume()
    }
    
    func showAlert(title: String, message: String, completion: (()->Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: completion)
    }
    
    func removeOrder() {
        for _ in orderedProducts {
            orderedProducts.remove(at: 0)
            tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .middle)
        }
        Cart.shared.removeAll()
    }

}

extension CartController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderedCell", for: indexPath) as! OrderedCell
        
        let orderedProduct = orderedProducts[indexPath.row]
        
        cell.cellProduct = orderedProduct
        
        cell.productImage.image = UIImage(named: orderedProduct.product.imageName)
        cell.nameLabel.text = orderedProduct.product.name
        cell.infoLabel.text = orderedProduct.size.rawValue.capitalized
        cell.quantityLabel.text = "\(orderedProduct.quantity)"
        cell.priceLabel.text = "$\(orderedProduct.totalPrice)"
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "There is nothing in your cart yet!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return orderedProducts.count == 0 ? 150 : 0
    }
    
}
