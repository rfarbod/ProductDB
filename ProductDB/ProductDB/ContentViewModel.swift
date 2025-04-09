//
//  ContentViewModel.swift
//  ProductDB
//
//  Created by Farbod on 4/9/25.
//

import AppDomain
import Combine
import Foundation
import SwiftData
import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var model: ContentModel
    var context: ModelContext?
    
    private var productsAPI: ProductAPI
    private var currentPage: Int = 0
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        productsAPI: ProductAPI,
        model: ContentModel
    ) {
        self.productsAPI = productsAPI
        self.model = model
    }
    
    func getProducts() {
        model.isLoading = true
        if !model.isFirstLoad {
            model.page += 1
        }
        
        let descriptor = FetchDescriptor<ContentModel>.init()
        if
            let result = try? context?.fetch(descriptor).last,
            result.page >= model.page
        {
            self.model.products = result.products
            self.model.page = result.page
        } else {
            productsAPI
                .list(page: model.page)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    guard let self else { return }
                    
                    switch completion {
                    case .finished:
                        self.model.isLoading = false
                        
                    case let .failure(error):
                        self.model.isLoading = false
                        print(error)
                    }
                } receiveValue: { [weak self] response in
                    guard let self else { return }
                    
                    self.model.products += response.products
                    
                    let newCachedModel = ContentModel(
                        isLoading: self.model.isLoading,
                        products: self.model.products,
                        page: self.model.page,
                        isFirstLoad: false
                    )
                    
                    context?.insert(newCachedModel)
                    try? context?.save()
                }
                .store(in: &cancellables)
        }
    }
}
