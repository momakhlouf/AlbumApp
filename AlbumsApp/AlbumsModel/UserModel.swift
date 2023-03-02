//
//  UserModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
  
}
