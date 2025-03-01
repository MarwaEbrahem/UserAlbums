//
//  File.swift
//  
//
//  Created by 2B on 05/08/2024.
//

import Foundation

public protocol ViewDataModelConvertible {
    associatedtype DomainType

    /// Used to convert any model to a corresponding domain model
    ///
    func toViewDataModel() -> DomainType
}
