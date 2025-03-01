//
//  AlbumDetailsUseCase.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import Networking

class AlbumDetailsUseCase {
    
    private static var networking: Network = AlamofireNetwork()
    let remote: AlbumDetailsRepoProtocol

    init(remote: AlbumDetailsRepoProtocol = AlbumDetailsRepo(network: networking)) {
        self.remote = remote
    }
    
    func getPhotos(_ albumId: Int, completion: @escaping (Result<[PhotoVM], Error>) -> Void) {
        remote.getPhotos(albumId, completion: { result in
            switch result {
            case let .success(data):
                let albums = data.map{$0.toViewDataModel()}
                completion(.success(albums))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
}

extension Photo: ViewDataModelConvertible {
    public func toViewDataModel() -> PhotoVM {
        return PhotoVM(title: title, id: id, url: url)
    }
}

public struct PhotoVM: Codable {
    let title: String
    let id: Int
    let url: String
}
