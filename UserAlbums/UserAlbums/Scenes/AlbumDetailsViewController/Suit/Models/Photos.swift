//
//  Albums.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation

// MARK: - Photo
public struct Photo: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

public typealias Photos = [Photo]
