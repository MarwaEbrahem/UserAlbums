//
//  File.swift
//  
//
//  Created by 2B on 05/08/2024.
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

