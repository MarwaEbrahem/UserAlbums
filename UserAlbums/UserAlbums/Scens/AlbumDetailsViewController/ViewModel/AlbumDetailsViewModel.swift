//  
//  AlbumDetailsViewModel.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import Networking

// MARK: AlbumDetailsViewModel

class AlbumDetailsViewModel {
    private var useCase: AlbumDetailsUseCase
    
    init(useCase: AlbumDetailsUseCase = AlbumDetailsUseCase()) {
        self.useCase = useCase
    }
    
    var state: ViewState = .empty {
        didSet {
            onUpdateLoadingStatus(state)
        }
    }
    
    var allPhotos: [PhotoVM] = []
    var filteredPhotos: [PhotoVM] = [] {
        didSet {
            onReloadData(filteredPhotos)
        }
    }
    
    var alertNetworkErrorMessage: String = "" {
        didSet {
            onShowNetworkErrorAlertClosure(alertNetworkErrorMessage)
        }
    }
    var onReloadData: (([PhotoVM]) -> Void) = { _ in }
    var onShowNetworkErrorAlertClosure: ((String) -> Void) = { _ in }
    var onUpdateLoadingStatus: ((ViewState) -> Void) = { _ in }
}

extension AlbumDetailsViewModel: AlbumDetailsViewModelType {
    
    func getPhotos(_ albumId: Int) {
        self.state = .loading
        if(!Connectivity.isConnectedToInternet){
            alertNetworkErrorMessage = "check your network connection"
            state = .error
            return
        }
        useCase.getPhotos(albumId, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                allPhotos = data
                filteredPhotos = data
                self.state = .loaded
            case .failure(let error):
                self.alertNetworkErrorMessage = error.localizedDescription
            }
        })
    }
}

extension AlbumDetailsViewModel {
    
    func getPhotosCount() -> Int {
        return filteredPhotos.count
    }
    
    func getPhoto(at index: Int) -> PhotoVM {
        return filteredPhotos[index]
    }
    
    func filterData(searchText: String) {
        if searchText.isEmpty {
            filteredPhotos = allPhotos
        } else {
            filteredPhotos = allPhotos.filter { photo in
                return photo.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
