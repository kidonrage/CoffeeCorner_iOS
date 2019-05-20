//
//  Order.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 15/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import Foundation

struct Order: Codable {
    var products: [OrderedProduct]
    var buyerName: String
}
