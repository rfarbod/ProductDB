//
//  ProductDBApp.swift
//  ProductDB
//
//  Created by Farbod on 4/9/25.
//

import SwiftUI
import SwiftData

@main
struct ProductDBApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(productsAPI: .init(), model: .init(isLoading: false, products: [], page: 0, isFirstLoad: true)))
        }
        .modelContainer(for: ContentModel.self)
    }
}
