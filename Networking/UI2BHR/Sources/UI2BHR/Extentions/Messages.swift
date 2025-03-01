//
//  File.swift
//  
//
//  Created by 2B on 29/09/2024.
//

import Foundation
import SwiftMessages
import UIKit

public class ShowNotificationMessages {
    
    private init() { }
    
    public static let sharedInstance = ShowNotificationMessages()
    
    public func showSnackBar(message: String) {
        // Use .messageView layout which doesn't include an icon by default
        let alert = MessageView.viewFromNib(layout: .messageView)
        alert.configureDropShadow()
        // Set background color
        alert.backgroundColor = .neutralWhite
        alert.iconLabel?.text = ""
        alert.iconImageView?.isHidden = true
        // Configure the content without setting an icon
        alert.configureContent(title:"",body: message)
        
        // Hide the button if not needed
        alert.button?.isHidden = true
        
        // Customize SwiftMessages config
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        infoConfig.presentationStyle = .top
        infoConfig.duration = .seconds(seconds: 3)
        
        // Show the message
        SwiftMessages.show(config: infoConfig, view: alert)
    }
}
