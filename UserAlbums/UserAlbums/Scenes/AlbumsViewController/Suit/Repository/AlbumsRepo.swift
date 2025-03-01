//
//  AlbumsRepo.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import Alamofire
import Networking

/// Protocol mainly used for mocking.
///
public protocol AlbumsRepoProtocol {
    func getUserAlbums(_ userId: Int, completion: @escaping (Result<Albums, Error>) -> Void)
    
    func getUsers(completion: @escaping (Result<Users, Error>) -> Void)
}


public class AlbumsRepo: Remote, AlbumsRepoProtocol {
    
    public func getUserAlbums(_ userId: Int, completion: @escaping (Result<Albums, Error>) -> Void) {
        
        let path = "albums"
        let parameters: Parameters = [
            "userId": userId
        ]
        
        let request = ApiRequest(method: .get, path: path, parameters: parameters)
        enqueue(request, completion: completion)
    }
    
    public func getUsers(completion: @escaping (Result<Users, Error>) -> Void) {
        let path = "users"
        
        let request = ApiRequest(method: .get, path: path)
        enqueue(request, completion: completion)
    }
}
