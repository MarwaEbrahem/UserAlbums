//  
//  AlbumDetailsViewModelType.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation

protocol AlbumDetailsViewModelType {
    var onShowNetworkErrorAlertClosure: (String) -> Void { get set }
    var onUpdateLoadingStatus: (ViewState) -> Void { get set }
    var onReloadData: ([PhotoVM]) -> Void { get set }
    var state: ViewState { get set }
    
    func getPhotos(_ albumId: Int)
    func getPhotosCount() -> Int
    func getPhoto(at index: Int) -> PhotoVM
    func filterData(searchText: String)
}

