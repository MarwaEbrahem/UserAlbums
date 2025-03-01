//
//  AlbumDetailsRepo.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import Alamofire
import Networking

/// Protocol mainly used for mocking.
///
public protocol AlbumDetailsRepoProtocol {
    func getPhotos(_ albumId: Int, completion: @escaping (Result<Photos, Error>) -> Void)
}


public class AlbumDetailsRepo: Remote, AlbumDetailsRepoProtocol {
    
    public func getPhotos(_ albumId: Int, completion: @escaping (Result<Photos, Error>) -> Void) {
        
        let path = "photos"
        let parameters: Parameters = [
            "albumId": albumId
        ]
        
        let request = ApiRequest(method: .get, path: path, parameters: parameters)
        enqueue(request, completion: completion)
    }
}
