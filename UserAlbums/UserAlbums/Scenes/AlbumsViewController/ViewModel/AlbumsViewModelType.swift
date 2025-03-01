//  
//  AlbumsViewModelType.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation


protocol AlbumsViewModelType {
    
    var onShowNetworkErrorAlertClosure: (String) -> Void { get set }
    var onUpdateLoadingStatus: (ViewState) -> Void { get set }
    var onReloadData: ([AlbumsVM], UserVM?) -> Void { get set }
    var state: ViewState { get set }
    
    func getProfileData()
    func getAlbumsCount() -> Int
    func getAlbum(at index: Int) -> AlbumsVM
}

