//
//  UserModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import Foundation

struct UserModel: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
}

// MARK: - Address
struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
}
