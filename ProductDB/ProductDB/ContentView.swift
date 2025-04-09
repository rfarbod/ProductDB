//
//  ContentView.swift
//  ProductDB
//
//  Created by Farbod on 4/9/25.
//

import AppUI
import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.model.products) { item in
                            ItemView(model: .init(
                                title: item.title,
                                description: item.description
                            ))
                            .onAppear {
                                if viewModel.model.products.last?.id == item.id {
                                    viewModel.getProducts()
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getProducts()
                
                if viewModel.model.isFirstLoad {
                    viewModel.model.isFirstLoad = false
                }
            }
            .padding()
        }
        .navigationTitle("Products")
    }
}

#Preview {
    ContentView(viewModel: .init(productsAPI: .init()))
}
