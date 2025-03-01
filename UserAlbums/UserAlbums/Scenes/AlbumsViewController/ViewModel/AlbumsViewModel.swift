//
//  AlbumsViewModel.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import Networking

// MARK: AlbumsViewModel

class AlbumsViewModel {
    
    private var useCase: AlbumsUseCase
    
    init(useCase: AlbumsUseCase = AlbumsUseCase()) {
        self.useCase = useCase
    }
    
    var state: ViewState = .empty {
        didSet {
            onUpdateLoadingStatus(state)
        }
    }
    var userData: UserVM?
    var allUserAlbums: [AlbumsVM] = [] {
        didSet {
            onReloadData(allUserAlbums, userData)
        }
    }
    
    var alertNetworkErrorMessage: String = "" {
        didSet {
            onShowNetworkErrorAlertClosure(alertNetworkErrorMessage)
        }
    }
    var onReloadData: (([AlbumsVM], UserVM?) -> Void) = { _, _ in }
    var onShowNetworkErrorAlertClosure: ((String) -> Void) = { _ in }
    var onUpdateLoadingStatus: ((ViewState) -> Void) = { _ in }
}

// MARK: AlbumsViewModel

extension AlbumsViewModel: AlbumsViewModelType {
    
    func getProfileData() {
        self.state = .loading
        if(!Connectivity.isConnectedToInternet){
            alertNetworkErrorMessage = "check your network connection"
            state = .error
            return
        }
        useCase.getUser(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                guard let randomUser = users.randomElement() else {
                    self.state = .error
                    self.alertNetworkErrorMessage = "No User Found"
                    return
                }
                userData = randomUser
                getUserAlbums(randomUser.id)
            case .failure(let error):
                self.alertNetworkErrorMessage = error.localizedDescription
            }
        })
    }
    
    func getUserAlbums(_ userId: Int) {
        self.state = .loading
        if(!Connectivity.isConnectedToInternet){
            alertNetworkErrorMessage = "check your network connection"
            state = .error
            return
        }
        useCase.getUserAlbums(userId, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                allUserAlbums = data
                self.state = .loaded
            case .failure(let error):
                self.state = .error
                self.alertNetworkErrorMessage = error.localizedDescription
            }
        })
    }
}

extension AlbumsViewModel {
    
    func getAlbumsCount() -> Int {
        return allUserAlbums.count
    }
    
    func getAlbum(at index: Int) -> AlbumsVM {
        return allUserAlbums[index]
    }
}


enum ViewState {
    case empty
    case loading
    case error
    case loaded
}
