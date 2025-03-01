//
//  Users.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import Foundation

// MARK: - User
public struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
public struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
public struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
public struct Company: Codable {
    let name, catchPhrase, bs: String
}

public typealias Users = [User]
