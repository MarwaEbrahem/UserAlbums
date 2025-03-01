//
//  File.swift
//  
//
//  Created by 2B on 11/08/2024.
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
