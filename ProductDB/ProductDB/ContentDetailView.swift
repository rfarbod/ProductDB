//
//  ContentDetailView.swift
//  ProductDB
//
//  Created by Farbod on 4/9/25.
//

import AppUI
import SwiftUI

struct ContentDetailView: View {
    let model: ContentDetailModel
    
    init(model: ContentDetailModel) {
        self.model = model
    }
    
    var body: some View {
        ItemView(model: .init(
            title: model.product.title,
            description: model.product.description,
            rate: model.product.rating,
            discountedPrice: model.product.price * (1 - model.product.discountPercentage / 100),
            stock: model.product.stock,
            isDetailed: true
        ))
    }
}
