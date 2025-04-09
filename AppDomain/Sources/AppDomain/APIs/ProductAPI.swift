//
//  ProductAPI.swift
//  AppDomain
//
//  Created by Farbod on 4/9/25.
//

import Combine
import Foundation

public protocol ProductAPIProtocol {
    func list(limit: Int, page: Int) -> AnyPublisher<ProductResponse, Error>
}

public final class ProductAPI: ProductAPIProtocol {
    private let networkManager: NetworkManagerProtocol
    private let jsonDecoder: JSONDecoder
    
    public init(
        networkManager: NetworkManagerProtocol = NetworkManager.shared,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.networkManager = networkManager
        self.jsonDecoder = jsonDecoder
    }
    
    public func list(limit: Int = 10, page: Int) -> AnyPublisher<ProductResponse, Error> {
        networkManager.request(
            api: ProductRequest.list(limit: limit, page: page),
            retryCount: 4
        )
        .tryMap { [weak self] data in
            guard let self else { throw APIError.invalidSelf }
            print(try! self.jsonDecoder.decode(ProductResponse.self, from: data))
            return try self.jsonDecoder.decode(ProductResponse.self, from: data)
        }
        .eraseToAnyPublisher()
    }
}
