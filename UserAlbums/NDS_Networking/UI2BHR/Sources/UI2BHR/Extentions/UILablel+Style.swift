//
//  File.swift
//  
//
//  Created by 2B on 06/08/2024.
//

import Foundation
import UIKit

@available(iOS 11.0, *)

public extension UILabel {
    enum labelStyle {
        case alertTitle(fontStyle: UIFont)
        case alertSubTitle(fontStyle: UIFont)
        case orangeTitle(fontStyle: UIFont)
        case placeHolderText(fontStyle: UIFont)
        case blackText(fontStyle: UIFont)
    }
    
    func applyLabelStyle(_ style: labelStyle) {
        switch style {
        case .alertTitle(fontStyle: let fontStyle):
            alertTitleStyle(fontStyle: fontStyle)
        case .alertSubTitle(fontStyle: let fontStyle):
            alertSubTitleStyle(fontStyle: fontStyle)
        case .orangeTitle(fontStyle: let fontStyle):
            orangeTitle(fontStyle: fontStyle)
        case .placeHolderText(fontStyle: let fontStyle):
            placeHolderText(fontStyle: fontStyle)
        case .blackText(fontStyle: let fontStyle):
            blackText(fontStyle: fontStyle)
        }
    }
}

extension UILabel {
    private func blackText(fontStyle: UIFont) {
        font = fontStyle
        textColor = .black
    }
    private func alertTitleStyle(fontStyle: UIFont) {
        font = fontStyle
        textColor = .secondaryColor
    }
    
    private func alertSubTitleStyle(fontStyle: UIFont) {
        font = fontStyle
        textColor = .grayBlack4
    }
    
    private func orangeTitle(fontStyle: UIFont) {
        font = fontStyle
        textColor = .thirdColor
    }
    
    private func placeHolderText(fontStyle: UIFont) {
        font = fontStyle
        textColor = .grayWhite2
    }
}

import ObjectiveC

private var textInsetsKey: UInt8 = 0

class PaddedLabel: UILabel {
    
    var textInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: textInsets)
        super.drawText(in: insetRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedSize = super.sizeThatFits(size)
        return CGSize(width: adjustedSize.width + textInsets.left + textInsets.right,
                      height: adjustedSize.height + textInsets.top + textInsets.bottom)
    }
}

class ActionableLabel: UILabel {

    var textDidChange: ((String?) -> Void)?

    override var text: String? {
        didSet {
            textDidChange?(text)
        }
    }
}
