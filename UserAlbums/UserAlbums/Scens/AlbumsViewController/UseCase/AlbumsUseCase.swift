//
//  AlbumsUseCase.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import Networking

class AlbumsUseCase {
    
    private static var networking: Network = AlamofireNetwork()
    let remote: AlbumsRepoProtocol

    init(remote: AlbumsRepoProtocol = AlbumsRepo(network: networking)) {
        self.remote = remote
    }
    
    func getUserAlbums(_ userId: Int, completion: @escaping (Result<[AlbumsVM], Error>) -> Void) {
        
        remote.getUserAlbums(userId, completion: { result in
            switch result {
                
            case let .success(data):
                let albums = data.map{$0.toViewDataModel()}
                completion(.success(albums))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
    
    func getUser(completion: @escaping (Result<[UserVM], Error>) -> Void) {
        
        remote.getUsers(completion: { result in
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

extension Album: ViewDataModelConvertible {
    public func toViewDataModel() -> AlbumsVM {
        return AlbumsVM(title: title, id: id)
    }
}

extension User: ViewDataModelConvertible {
    public func toViewDataModel() -> UserVM {
        return UserVM(name: name, id: id, street: address.street, suite: address.suite, city: address.city, zipcode: address.zipcode)
    }
}

public struct AlbumsVM: Codable {
    let title: String
    let id: Int
}

public struct UserVM: Codable {
    let name: String
    let id: Int
    let street, suite, city, zipcode: String
}
