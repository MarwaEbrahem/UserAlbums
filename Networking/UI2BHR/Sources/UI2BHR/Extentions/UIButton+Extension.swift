//
//  File.swift
//  
//
//  Created by 2B on 31/08/2024.
//

import Foundation
import UIKit

public extension UIButton {
    
    func addBadgeView(_ tag: Int) {
        let badgeView = UIView()
        badgeView.tag = tag
        badgeView.backgroundColor = .orange
        
        let badgeSize: CGFloat = 8
        badgeView.frame = CGRect(x: frame.width - badgeSize / 2, y: -badgeSize / 2, width: badgeSize, height: badgeSize)
        badgeView.layer.cornerRadius = badgeSize / 2
        badgeView.layer.masksToBounds = true
        
       addSubview(badgeView)
    }
    
    func removeBadgeView(_ tag: Int) {
        if let badgeView = viewWithTag(tag) {
            badgeView.removeFromSuperview()
        }
    }
}
