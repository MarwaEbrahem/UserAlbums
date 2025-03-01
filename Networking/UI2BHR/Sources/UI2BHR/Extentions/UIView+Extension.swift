//
//  File.swift
//
//
//  Created by 2B on 06/08/2024.
//

import Foundation
import UIKit

public extension UIView {
    
    func roundCorners(cornerType: CornerType = .all, radius: CGFloat) {
        // Reset previous settings
        self.layer.cornerRadius = 0
        self.layer.maskedCorners = []
        
        switch cornerType {
        case .topLeft:
            self.layer.maskedCorners = [.layerMinXMinYCorner]
        case .topRight:
            self.layer.maskedCorners = [.layerMaxXMinYCorner]
        case .bottomLeft:
            self.layer.maskedCorners = [.layerMinXMaxYCorner]
        case .bottomRight:
            self.layer.maskedCorners = [.layerMaxXMaxYCorner]
        case .topThree:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .bottomThree:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        case .top:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .all:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .left:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .right:
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowRadius = 5
        
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: bounds.height - 3))
        shadowPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height - 3))
        shadowPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        shadowPath.addLine(to: CGPoint(x: 0, y: bounds.height))
        shadowPath.close()
        
        layer.shadowPath = shadowPath.cgPath
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
    
    func addDashedLine(lineWidth: CGFloat, lineColor: UIColor, dashPattern: [NSNumber] = [6, 3]) {
        let dashedLine = CAShapeLayer()
        dashedLine.strokeColor = lineColor.cgColor
        dashedLine.lineWidth = lineWidth
        dashedLine.lineDashPattern = dashPattern
        dashedLine.fillColor = nil
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: self.bounds.height / 2))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height / 2))
        
        dashedLine.path = path.cgPath
        self.layer.addSublayer(dashedLine)
    }
    
    func addButton(_ button: UIButton , _ tag: Int) {
        button.tag = tag
        addSubview(button)
    }
    
    func removeButton(_ button: UIButton , _ tag: Int) {
        if let viewWithTag = viewWithTag(tag) {
            viewWithTag.removeFromSuperview()
        }
    }
    
}

public enum CornerType {
    case top
    case left
    case right
    case bottom
    case all
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case topThree  // Rounds top-left, top-right, bottom-right
    case bottomThree // Rounds top-left, top-right, bottom-left
}


