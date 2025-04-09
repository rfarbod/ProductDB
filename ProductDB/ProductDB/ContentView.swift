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
    @Environment(\.modelContext) private var context
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.model.products) { item in
                            NavigationLink(destination: ContentDetailView(model: .init(product: item))) {
                                ItemView(model: .init(
                                    title: item.title,
                                    description: item.description,
                                    rate: item.rating
                                ))
                            }
                            .buttonStyle(PlainButtonStyle())
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
                viewModel.context = context
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
