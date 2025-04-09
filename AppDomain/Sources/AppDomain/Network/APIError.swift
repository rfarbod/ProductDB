//
//  APIError.swift
//  AppDomain
//
//  Created by Farbod on 4/9/25.
//

public enum APIError: Error, CustomStringConvertible, Equatable {
    case badRequest
    case authError
    case serverError
    case unknown
    case invalidSelf
    
    public var description: String {
        switch self {
        case .badRequest:
            return "bad request"
        case .authError:
            return "authorization error"
        case .serverError:
            return "server error"
        case .unknown:
            return "unknown error"
        case .invalidSelf:
            return "invalid self"
        }
    }
}
