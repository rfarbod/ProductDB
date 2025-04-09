//
//  ProductRequest.swift
//  AppDomain
//
//  Created by Farbod on 4/9/25.
//

import Foundation

enum ProductRequest {
    case list(limit: Int, page: Int)
}

extension ProductRequest: RequestProtocol {
    var timeoutInterval: TimeInterval {
        return 30.0
    }
    
    var path: String {
        switch self {
        case .list:
            return "/products"
        }
    }
    
    var parameters: RequestParameters? {
        switch self {
        case let .list(limit, page):
            return [
                "limit": limit,
                "skip": page * limit
            ]
        }
    }
}
