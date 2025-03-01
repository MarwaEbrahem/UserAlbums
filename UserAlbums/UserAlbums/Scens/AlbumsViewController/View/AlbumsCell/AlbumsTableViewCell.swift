//
//  AlbumsTableViewCell.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import UIKit
import UI

class AlbumsTableViewCell: UITableViewCell, IdentifiableView {

    @IBOutlet private(set) weak var albumTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with viewModel: AlbumsVM) {
        albumTitle.text = viewModel.title
    }
    
}
