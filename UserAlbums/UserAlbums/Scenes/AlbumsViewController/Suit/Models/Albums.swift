//
//  Albums.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation

// MARK: - Album
public struct Album: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

public typealias Albums = [Album]
