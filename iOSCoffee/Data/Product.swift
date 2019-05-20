//
//  CoffeeType.swift
//  iOSCoffee
//
//  Created by Vlad Eliseev on 15/05/2019.
//  Copyright © 2019 Vlad Eliseev. All rights reserved.
//

import Foundation

struct Product: Codable {
    var name: String
    var type: ProductType
    var description: String
    var usdPrice: Int
    var imageName: String
}
