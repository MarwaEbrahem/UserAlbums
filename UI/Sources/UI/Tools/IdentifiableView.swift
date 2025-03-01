//
//  File.swift
//  
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import UIKit

public protocol IdentifiableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension IdentifiableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
