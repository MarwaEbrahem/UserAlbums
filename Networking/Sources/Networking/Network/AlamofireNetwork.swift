//
//  File.swift
//  
//
//  Created by marwa on 1/03/2025.
//

import Alamofire
import Foundation

/// AlamofireWrapper: Encapsulates all of the Alamofire OP's
///
public class AlamofireNetwork: Network {

    public init() {}

    /// Executes the specified Network Request. Upon completion, the payload will be sent back to the caller as a Data instance.
    ///
    public func responseData(for request: URLRequestConvertible, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(request).responseData { response in
            if let data = response.data {
                    let jsonString = String(data: data, encoding: .utf8)
                }
            completion(response.result.toSwiftResult())
        }
    }
}

// MARK: - Swift.Result Conversion

//
private extension Result where Failure == AFError {
    /// Convert this `Alamofire.Result` to a `Swift.Result`.
    ///
    func toSwiftResult() -> Swift.Result<Success, Error> {
        switch self {
        case let .success(value):
            return .success(value)
        case let .failure(error):
            return .failure(error)
        }
    }
}

