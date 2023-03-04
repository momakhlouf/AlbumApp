//
//  PhotoModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation

struct PhotoModel: Codable {
    let albumId, id: Int
    let title: String
    let url, thumbnailUrl: String
}
