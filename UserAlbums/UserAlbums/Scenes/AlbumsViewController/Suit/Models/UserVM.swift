//
//  UserVM.swift
//  UserAlbums
//
//  Created by marwa on 02/03/2025.
//

public struct UserVM: Codable {
    let name: String
    let id: Int
    let street, suite, city, zipcode: String
}
