//
//  File.swift
//  
//
//  Created by marwa on 1/03/2025.
//

import Foundation

///  Response Validator
///
struct RemoteErrorValidator {

    /// Returns the DotcomError contained in a given Data Instance (if any).
    ///
    static func error(from response: Data) -> Error? {
        return try? JSONDecoder().decode(RemoteError.self, from: response)
    }
}

