//
//  ItemViewMOdel.swift
//  AppUI
//
//  Created by Farbod on 4/9/25.
//

public struct ItemViewModel: Sendable {
    public let title: String
    public let description: String
    public let rate: Double
    public let price: Double
    
    public init(
        title: String = Self.default.title,
        description: String = Self.default.description,
        rate: Double = Self.default.rate,
        price: Double = Self.default.price
    ) {
        self.title = title
        self.description = description
        self.rate = rate
        self.price = price
    }
}

extension ItemViewModel {
    public static let `default`: ItemViewModel = .init(
        title: "",
        description: "",
        rate: 0,
        price: 0
    )
}
