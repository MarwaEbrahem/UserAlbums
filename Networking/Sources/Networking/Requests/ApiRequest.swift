//
//  File.swift
//  
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import Alamofire

/// Represents Fakestore.com Endpoint
///
public struct ApiRequest: URLRequestConvertible {

    /// HTTP Request Method
    ///
    let method: HTTPMethod

    /// URL Path
    ///
    let path: String

    /// Parameters
    ///
    let parameters: [String: Any]

    /// Headers
    ///
    let headers: HTTPHeaders
    
    
    /// Designated Initializer.
    ///
    /// - Parameters:
    ///     - method: HTTP Method we should use.
    ///     - path: RPC that should be called.
    ///     - parameters: Collection of Key/Value parameters, to be forwarded to the Jetpack Connected site.

    public init(method: HTTPMethod, path: String, parameters: [String: Any]? = nil, header: HTTPHeaders? = nil) {
        self.method = method
        self.path = path
        self.parameters = parameters ?? [:]
        self.headers = header ?? [:]
    }

    /// Returns a URLRequest instance reprensenting the current FakeStore Request.
    ///
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: Settings.ApiBaseURL + path)!
        let request = try URLRequest(url: url, method: method, headers: headers)
        return try encoder.encode(request, with: parameters)
        
    }
}

// MARK: - SMS Request: Internal

//
private extension ApiRequest {

    /// Returns the Parameters Encoder
    ///
    var encoder: ParameterEncoding {
        return method == .get ? URLEncoding.queryString : JSONEncoding.default
    }
}

