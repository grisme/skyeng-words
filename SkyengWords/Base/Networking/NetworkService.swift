//
//  NetworkService.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation
import Alamofire

/// Network service
/// Incapsulates networking layer of the application
final class NetworkService: Networking {
    
    // MARK: - Declarations
    
    /// Enumerates possible APIs for the application
    enum API: String {
        case production
        // case debug
        
        /// Returns specified API's URL
        var url: String {
            switch self {
            case .production:
                return "https://dictionary.skyeng.ru/api/public/v1"
            }
        }
    }
    
    // MARK: - Properties
    
    /// Network requests performing queue
    private let networkQueue: DispatchQueue = {
        DispatchQueue.global(qos: .background)
    }()
    
    /// Target networking API
    private let api: API = {
        // There can be additional logic, i.e. debug / production detection
        .production
    }()
    
    // MARK: - Private methods
    
    /// Builds URL for current API and specified endpoint
    /// - Parameter endpoint: Request endpoint
    /// - Returns: Optional URL
    private func buildURL(with endpoint: String?) -> URL? {
        var targetURL = api.url
        if let endpoint = endpoint {
            targetURL += endpoint
        }
        return URL(string: targetURL)
    }
    
    /// Maps most abstract `request type` intto incapsulated networking library realization
    /// - Parameter requestType: Target request type
    /// - Returns: Optional library's HTTP method
    private func httpMethod(from requestType: RequestType) -> HTTPMethod? {
        switch requestType {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
    
    /// Returns parameter encoder for specified request type
    /// - Parameter requestType: Specified request type
    /// - Returns: Parameter encoder
    private func parameterEncoder(for requestType: RequestType) -> ParameterEncoder {
        let encoder: ParameterEncoder
        switch requestType {
        case .post:
            let jsonEncoder = JSONEncoder()
            encoder = JSONParameterEncoder(encoder: jsonEncoder)
        case .get:
            encoder = URLEncodedFormParameterEncoder.default
        }
        return encoder
    }
    
    // MARK: - Networking protocol implementation
    
    func performRequest<Parameters: Encodable>(endpoint: String?, type: RequestType, params: Parameters?, completion: @escaping RequestCompletion) {

        // Calculating target URL
        guard let url = buildURL(with: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Calculating HTTP request method
        guard let httpMethod = httpMethod(from: type) else {
            completion(.failure(.unsupportedHTTPMethod))
            return
        }
        
        // Calculating parameters encoder
        let paramsEncoder = parameterEncoder(for: type)
        
        // Performing request
        AF.request(
            url,
            method: httpMethod,
            parameters: params,
            encoder: paramsEncoder,
            headers: nil
        )
        .validate(statusCode: 200...299)
        .responseData(queue: self.networkQueue) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let aferror):
                completion(.failure(.requestError(code: aferror.responseCode ?? -1)))
            }
        }

    }

}
