//
//  Networking.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 10.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

/// Enumerates possible networking layer errors
enum NetworkError: LocalizedError {
    
    case invalidURL
    case unsupportedHTTPMethod
    case requestError(code: Int)
    case nodataError
    
    /// Returns error's localized description
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Failed to build valid URL to specified endpoint"
        case .requestError(let code):
            return "Request failed with code \(code)"
        case .unsupportedHTTPMethod:
            return "Network layer doesn't support HTTP method"
        case .nodataError:
            return "No data received"
        }
    }
}

/// Request completion closure declaration
typealias RequestCompletion = (_ result: Result<Data, NetworkError>) -> Void

/// Describes common networking service interface
protocol Networking: class {
    
    /// Performs network request
    /// - Parameters:
    ///   - type: Request type
    ///   - params: Optional request parameters
    ///   - completion: Completion block
    ///   - url: Target request URL
    func performRequest<Parameters: Encodable>(endpoint: String?, type: RequestType, params: Parameters?, completion: @escaping RequestCompletion)
}
