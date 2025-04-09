//
//  Product.swift
//  AppDomain
//
//  Created by Farbod on 4/9/25.
//

import Foundation

public struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let rating: Double
}
