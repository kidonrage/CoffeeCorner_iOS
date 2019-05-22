//
//  Cart.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 17/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import Foundation

class Cart {
    
    static let shared = Cart()
    private var orderedProducts: [OrderedProduct] = []
    
    func addToCart(ordered: OrderedProduct) {
        var isUnique = true
        for (index, product) in orderedProducts.enumerated() {
            if ordered.product.name == product.product.name &&
            ordered.size == product.size {
                isUnique = false
                orderedProducts[index].quantity += 1
                break
            }
        }
        if isUnique {
            orderedProducts.append(ordered)
        }
    }
    
    func increaseQuantity(forIndex index: Int) {
        orderedProducts[index].quantity += 1
    }
    func decreaseQuantity(forIndex index: Int) {
        orderedProducts[index].quantity -= 1
    }
    
    func getProducts() -> [OrderedProduct] {
        return self.orderedProducts
    }
    
    func removeFromCart(productIndex: Int) {
        orderedProducts.remove(at: productIndex)
    }
    
    func removeAll() {
        orderedProducts.removeAll()
        print("Deleting ordered products...\(orderedProducts.count)")
    }
}
