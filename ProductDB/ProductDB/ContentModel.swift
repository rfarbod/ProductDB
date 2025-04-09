//
//  ContentModel.swift
//  ProductDB
//
//  Created by Farbod on 4/9/25.
//

import AppDomain

struct ContentModel {
    var isLoading: Bool
    var products: [Product]
    var page: Int
    var isFirstLoad: Bool
    
    init(
        isLoading: Bool = Self.default.isLoading,
        products: [Product] = Self.default.products,
        page: Int = Self.default.page,
        isFirstLoad: Bool = Self.default.isFirstLoad
    ) {
        self.isLoading = isLoading
        self.products = products
        self.page = page
        self.isFirstLoad = isFirstLoad
    }
}

extension ContentModel {
    static let `default`: ContentModel = .init(
        isLoading: false,
        products: [],
        page: 0,
        isFirstLoad: true
    )
}
