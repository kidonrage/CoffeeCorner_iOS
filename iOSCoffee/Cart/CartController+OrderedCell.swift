//
//  CartController+OrderedCell.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 18/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import UIKit

extension CartController: OrderedCellDelegate{
    func didAddProduct(_ product: OrderedProduct) {
        let productIndex = orderedProducts.firstIndex {
            $0.product.name == product.product.name && $0.size == product.size
        }
        guard let index = productIndex else {return}
        let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! OrderedCell
        orderedProducts[index].quantity += 1
        cell.quantityLabel.text = "\(orderedProducts[index].quantity)"
        cell.priceLabel.text = "$\(orderedProducts[index].totalPrice)"
        Cart.shared.increaseQuantity(forIndex: index)
    }
    
    func didRemoveProduct(_ product: OrderedProduct) {
        let productIndex = orderedProducts.firstIndex {
            $0.product.name == product.product.name && $0.size == product.size
        }
        guard let index = productIndex else {return}
        let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! OrderedCell
        if orderedProducts[index].quantity > 1 {
            orderedProducts[index].quantity -= 1
            cell.quantityLabel.text = "\(orderedProducts[index].quantity)"
            cell.priceLabel.text = "$\(orderedProducts[index].totalPrice)"
            Cart.shared.decreaseQuantity(forIndex: index)
        } else {
            Cart.shared.removeFromCart(productIndex: index)
            orderedProducts = Cart.shared.getProducts()
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .middle)
        }
    }
}
