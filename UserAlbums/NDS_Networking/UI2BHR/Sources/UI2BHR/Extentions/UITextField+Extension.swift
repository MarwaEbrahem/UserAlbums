//
//  File.swift
//  
//
//  Created by 2B on 19/08/2024.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public extension UITextField {
    
    func chanageDirection() {
        if UserDefaults.standard.string(forKey: "UKPrefLang")! == "ar" {
            semanticContentAttribute = .forceRightToLeft
            textAlignment = .right
        }else {
            semanticContentAttribute = .forceLeftToRight
            textAlignment = .left
        }
    }
    
    func applyBordertextFieldStyle(_ style: TextFieldStateStyle) {
        
        chanageDirection()
        backgroundColor = .neutralWhite
        layer.cornerRadius = 12
        layer.masksToBounds = true
        textColor = .secondaryColor
        font = .semiBold_14
        layer.borderWidth = 1
        
        switch style {
        case .defaultState:
            layer.borderColor = UIColor.grayWhite5.cgColor
        case .errorState:
            layer.borderColor = UIColor.redState.cgColor
        case .selectedState:
            layer.borderColor = UIColor.secondaryColor.cgColor
        }
        
        borderStyle = .roundedRect
        
    }
    
    func applyBordertextFieldStyle(_ placeholder: String) {
        
        chanageDirection()
        backgroundColor = .neutralWhite
        textColor = .secondaryColor
        font = .semiBold_12
        
        self.placeholder = placeholder
        let placeholderText = self.placeholder ?? placeholder
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.placeholderText,
            .font: UIFont.semiBold_12
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    }
    
    enum TextFieldStateStyle {
        case defaultState
        case errorState
        case selectedState
    }
}



