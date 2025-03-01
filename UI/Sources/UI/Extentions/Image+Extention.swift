//
//  Image+Style.swift
//  UI
//
//  Created by marwa on 1/03/2025.

import UIKit
import Kingfisher

extension UIImageView {
    public func loadImageWithFallback(from url: String?, placeholderColors: [UIColor] = [.red, .blue, .green, .yellow, .orange, .purple]) {
        guard let urlString = url, let imageURL = URL(string: urlString) else {
            setRandomBackgroundColor(from: placeholderColors)
            return
        }
        
        self.kf.setImage(with: imageURL, completionHandler: { result in
            switch result {
            case .success:
                self.backgroundColor = .clear
            case .failure:
                self.setRandomBackgroundColor(from: placeholderColors)
            }
        })
    }
    
    private func setRandomBackgroundColor(from colors: [UIColor]) {
        self.backgroundColor = (colors.randomElement() ?? .gray).withAlphaComponent(0.8)
    }
}
