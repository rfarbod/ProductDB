//
//  RequestProtocol.swift
//  AppDomain
//
//  Created by Farbod on 4/9/25.
//

import Foundation

public typealias RequestParameters = [String: Any]
typealias RequestHeaders = [String: String]
typealias RequestBody = [String: Any?]

public enum RequestMethod: String { case get = "GET" }
enum RequestType { case data }
enum ResponseType { case json }

let baseURL = "https://dummyjson.com/docs/products"

public protocol RequestProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: RequestParameters? { get }
    var timeoutInterval: TimeInterval { get }
    var retryDelay: UInt64 { get }
}

extension RequestProtocol {
    var baseURL: String { baseURL }
    var method: RequestMethod { .get }
    var requestType: RequestType { .data }
    var responseType: ResponseType { .json }
    var timeInterval: TimeInterval { 30.0 }
    var retryDelay: UInt64 { 1_000_000_000 }
    
    private var queryItems: [URLQueryItem]? {
        guard let parameters else { return nil }
        
        return parameters.map { (key: String, value: Any) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }
    
    private func url() -> URL? {
        guard var urlComponent = URLComponents(string: baseURL) else { return nil }
        
        urlComponent.path = urlComponent.path + path
        urlComponent.queryItems = queryItems
        return urlComponent.url
    }
    
    func urlRequest() -> URLRequest? {
        guard let url = url() else { return nil }
        
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue
        request.cachePolicy = .returnCacheDataElseLoad
        
        return request
    }
    
    func verifyResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        switch httpResponse.statusCode {
        case 200...299:
            return data
        case 401:
            throw APIError.authError
        case 400...499:
            throw APIError.badRequest
        case 500...599:
            throw APIError.serverError
        default:
            throw APIError.unknown
        }
    }
}
