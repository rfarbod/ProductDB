//
//  ProductDBApp.swift
//  ProductDB
//
//  Created by Farbod on 4/9/25.
//

import SwiftUI

@main
struct ProductDBApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(productsAPI: .init()))
        }
    }
}
