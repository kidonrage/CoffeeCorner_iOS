//
//  OrderedProduct.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 18/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import Foundation

struct OrderedProduct: Codable {
    var product: Product
    var size: ProductSize
    var quantity: Int = 1
    var totalPrice: Int {
        if self.size == .standard {
            return self.product.usdPrice * self.quantity
        } else {
            return (self.product.usdPrice + self.product.usdPrice / 3) * self.quantity
        }
    }
}
