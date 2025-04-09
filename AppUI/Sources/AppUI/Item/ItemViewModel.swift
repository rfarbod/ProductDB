//
//  ItemViewMOdel.swift
//  AppUI
//
//  Created by Farbod on 4/9/25.
//

import SwiftUI

public struct ItemViewModel: Sendable {
    public let title: String
    public let description: String
    public let rate: Double
    public let price: Double
    public let discountedPrice: Double
    public let stock: Int
    public let isDetailed: Bool
    
    public var imgeResource: Image? {
        switch rate {
        case 0..<3:
            return Image(systemName: "star")
            
        case 3..<4:
            return Image(systemName: "star.leadinghalf.filled")
            
        default:
            return Image(systemName: "star.fill")
        }
    }
    
    public init(
        title: String = Self.default.title,
        description: String = Self.default.description,
        rate: Double = Self.default.rate,
        price: Double = Self.default.price,
        discountedPrice: Double = Self.default.discountedPrice,
        stock: Int = Self.default.stock,
        isDetailed: Bool = Self.default.isDetailed
    ) {
        self.title = title
        self.description = description
        self.rate = rate
        self.price = price
        self.discountedPrice = discountedPrice
        self.stock = stock
        self.isDetailed = isDetailed
    }
}

extension ItemViewModel {
    public static let `default`: ItemViewModel = .init(
        title: "",
        description: "",
        rate: 0,
        price: 0,
        discountedPrice: 0,
        stock: 0,
        isDetailed: false
    )
}
