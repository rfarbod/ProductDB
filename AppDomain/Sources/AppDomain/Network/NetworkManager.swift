//
//  NetworkManager.swift
//  AppDomain
//
//  Created by Farbod on 4/9/25.
//

import Foundation
import Combine

public protocol NetworkManagerProtocol {
    func request(api: RequestProtocol, retryCount: Int) -> AnyPublisher<Data, Error>
}

public final class NetworkManager: NetworkManagerProtocol, Sendable {
    static public let shared = NetworkManager()
    let urlSession: URLSession
    
    private init(config: URLSessionConfiguration = .default) {
        self.urlSession = URLSession(configuration: config)
    }
    
    public func request(api: any RequestProtocol, retryCount: Int) -> AnyPublisher<Data, any Error> {
        guard let apiRequest = api.urlRequest() else {
            return Fail(error: APIError.badRequest).eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: apiRequest)
            .retry(retryCount)
            .tryMap { (data, response) in
                print(response)
                return try api.verifyResponse(data: data, response: response)
            }
            .eraseToAnyPublisher()
    }
}
