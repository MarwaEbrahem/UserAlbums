//
//  File.swift
//  
//
//  Created by 2B on 05/08/2024.
//

import Foundation
import UIKit

public extension UIButton {

    enum buttonStyle {
        case filledStyle(fontStyle: UIFont)
        case disableFilledStyle(fontStyle: UIFont)
        case withBorderStyle(fontStyle: UIFont)
        case withDeleteBorderStyle(fontStyle: UIFont)
        case plainStyle(fontStyle: UIFont)
        case disabledBorderdStyle(fontStyle: UIFont)
        case filledWithImage(fontStyle: UIFont, imageName: String)
        case borderWithImage(fontStyle: UIFont, imageName: String)
        case selectedSegmentedControl(isLanguageStyle: Bool = true)
        case unSelectedSegmentedControl
    }

    func applyButtonStyle(_ style: buttonStyle) {
        switch style {
        case .filledStyle(fontStyle: let fontStyle):
            filledStyle(fontStyle: fontStyle)
        case .withBorderStyle(fontStyle: let fontStyle):
            withBorderStyle(fontStyle: fontStyle)
        case .withDeleteBorderStyle(fontStyle: let fontStyle):
            withDeleteBorderStyle(fontStyle: fontStyle)
        case .plainStyle(fontStyle: let fontStyle):
            plainStyle(fontStyle: fontStyle)
        case .filledWithImage(fontStyle: let fontStyle, imageName: let imageName):
            filledWithImage(fontStyle: fontStyle, imageName: imageName)
        case .borderWithImage(fontStyle: let fontStyle, imageName: let imageName):
            borderWithImage(fontStyle: fontStyle, imageName: imageName)
        case .disabledBorderdStyle(fontStyle: let fontStyle): disabledBorderdStyle(fontStyle: fontStyle)
        case .disableFilledStyle(fontStyle: let fontStyle):
            disableFilledStyle(fontStyle: fontStyle)
        case .selectedSegmentedControl(isLanguageStyle: let isLanguageStyle):
            selectedSegmentedStyle(isLanguageStyle)
        case .unSelectedSegmentedControl:
            unSelectedSegmentStyle()
        }
    }
}

extension UIButton {
    
    private func unSelectedSegmentStyle() {
        titleLabel?.font = .regular_12
        tintColor = .secondaryColor
        backgroundColor = .clear
        layer.borderWidth = 0
    }
    
    
    private func selectedSegmentedStyle(_ isLanguageStyle: Bool) {
        titleLabel?.font = .regular_12
        tintColor = .thirdColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
        backgroundColor = .orangeShaded
        if !isLanguageStyle {
            layer.borderWidth = 1
            layer.borderColor = UIColor.thirdColor.cgColor
        }
        
    }
    
    // MARK: - Filled Buttons style
    private func disabledBorderdStyle(fontStyle: UIFont) {
        titleLabel?.font = fontStyle
        tintColor = .grayWhite3
        layer.cornerRadius = 16
        layer.masksToBounds = true
        backgroundColor = .grayWhite5
        layer.borderWidth = 1
        layer.borderColor = UIColor.grayWhite3.cgColor
    }
    
    private func filledStyle(fontStyle: UIFont) {
        titleLabel?.font = fontStyle
        tintColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
        backgroundColor = .thirdColor
    }
    
    private func disableFilledStyle(fontStyle: UIFont) {
        titleLabel?.font = fontStyle
        tintColor = UIColor.grayWhite3
        layer.cornerRadius = 16
        layer.masksToBounds = true
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.grayWhite3.cgColor
    }
    
    private func withBorderStyle(fontStyle: UIFont) {
        titleLabel?.font = fontStyle
        tintColor = .thirdColor
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.thirdColor.cgColor
        layer.masksToBounds = true
        backgroundColor = .white
    }
    
    private func withDeleteBorderStyle(fontStyle: UIFont) {
        titleLabel?.font = fontStyle
        tintColor = .redState
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.redState.cgColor
        layer.masksToBounds = true
        backgroundColor = .white
    }
    
    private func plainStyle(fontStyle: UIFont) {
        titleLabel?.font = fontStyle
        tintColor = .thirdColor
        layer.masksToBounds = true
        backgroundColor = .clear
    }
    
    private func filledWithImage(fontStyle: UIFont, imageName: String) {
        titleLabel?.font = fontStyle
        tintColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .thirdColor
        setImage(UIImage(named: imageName), for: .normal)
        if UserDefaults.standard.string(forKey: "UKPrefLang")! == "ar" {
            semanticContentAttribute = .forceRightToLeft
        } else {
            semanticContentAttribute = .forceLeftToRight
        }
        
    }
    
    private func borderWithImage(fontStyle: UIFont, imageName: String) {
        titleLabel?.font = fontStyle
        tintColor = .thirdColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.thirdColor.cgColor
        backgroundColor = .white
        setImage(UIImage(named: imageName), for: .normal)
        semanticContentAttribute = .forceRightToLeft
    }
}

@available(iOS 15.0, *)
public extension UIButton {
    func applyImagePaddingConfiguration(_ padding: Int) {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = CGFloat(padding)
        configuration.imagePlacement = .leading
        self.configuration = configuration
    }
}
