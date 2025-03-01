//
//  UILabel+Style.swift
//  UI
//
//  Created by marwa on 1/03/2025.
//

import UIKit

class LabelWithPadding: UILabel {
    
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
