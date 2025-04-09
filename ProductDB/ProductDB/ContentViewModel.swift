//
//  ContentViewModel.swift
//  ProductDB
//
//  Created by Farbod on 4/9/25.
//

import AppDomain
import Combine
import Foundation

final class ContentViewModel: ObservableObject {
    @Published var model: ContentModel = .default
    
    private var productsAPI: ProductAPI
    private var currentPage: Int = 0
    private var cancellables: Set<AnyCancellable> = []
    
    init(productsAPI: ProductAPI) {
        self.productsAPI = productsAPI
    }
    
    func getProducts() {
        model.isLoading = true
        if !model.isFirstLoad {
            model.page += 1
        }
        
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
            }
            .store(in: &cancellables)
    }
}
