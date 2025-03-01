//
//  File.swift
//  
//
//  Created by marwa on 1/03/2025.
//

import Foundation

public protocol ViewDataModelConvertible {
    associatedtype DomainType

    /// Used to convert any model to a corresponding domain model
    ///
    func toViewDataModel() -> DomainType
}
