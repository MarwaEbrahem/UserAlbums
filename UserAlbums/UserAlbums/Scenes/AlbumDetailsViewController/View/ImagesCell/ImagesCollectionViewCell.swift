//
//  ImagesCollectionViewCell.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import UIKit
import UI

class ImagesCollectionViewCell: UICollectionViewCell, IdentifiableView {
    
    @IBOutlet private(set) weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with viewModel: PhotoVM) {
        photoView.loadImageWithFallback(from: viewModel.url)
    }

}
