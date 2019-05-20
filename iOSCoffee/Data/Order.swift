//
//  Order.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 15/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import Foundation

struct Order: Codable {
    var products: [[String : Int]]
    var buyerName: String
    var total: Int
}
