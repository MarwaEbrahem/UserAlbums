//
//  File.swift
//  
//
//  Created by 2B on 27/08/2024.
//

import Foundation
import UIKit

public extension UIViewController {
    
    func showToast(message: String, font: UIFont, textColor: UIColor, backgroundViewColor: UIColor) {
        
        let toastLabel = PaddedLabel()
        toastLabel.backgroundColor = backgroundViewColor
        toastLabel.textColor = textColor
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20
        toastLabel.clipsToBounds  =  true
        
        
        toastLabel.textInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toastLabel)
        
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
            toastLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20),
            toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toastLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150),
            toastLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { (isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
    
    
    func showAddedToast(_ msg: String) {
        showToast(message: msg, font: .semiBold_14, textColor: .secondaryColor, backgroundViewColor: .grayWhite3)
    }
    
}

