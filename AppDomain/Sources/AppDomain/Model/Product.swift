//
//  Product.swift
//  AppDomain
//
//  Created by Farbod on 4/9/25.
//

import Foundation

public struct Product: Codable, Identifiable {
    public let id: Int
    public let title: String
    public let description: String
    public let price: Double
    public let discountPercentage: Double
    public let rating: Double
    public let stock: Int
}
