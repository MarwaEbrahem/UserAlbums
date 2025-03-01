//
//  File.swift
//  
//
//  Created by 2B on 22/09/2024.
//

import Foundation
import UIKit

public extension UITextView {
    
    func chanageDirection() {
        if UserDefaults.standard.string(forKey: "UKPrefLang")! == "ar" {
            semanticContentAttribute = .forceRightToLeft
            textAlignment = .right
        }else {
            semanticContentAttribute = .forceLeftToRight
            textAlignment = .left
        }
    }
}
