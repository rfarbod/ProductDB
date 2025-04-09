//
//  ContentModel.swift
//  ProductDB
//
//  Created by Farbod on 4/9/25.
//

import AppDomain
import Foundation
import SwiftData

@Model
class ContentModel: Identifiable {
    var id: UUID
    var isLoading: Bool
    var products: [Product]
    var page: Int
    var isFirstLoad: Bool
    
    init(
        isLoading: Bool,
        products: [Product],
        page: Int,
        isFirstLoad: Bool
    ) {
        self.id = UUID()
        self.isLoading = isLoading
        self.products = products
        self.page = page
        self.isFirstLoad = isFirstLoad
    }
}
