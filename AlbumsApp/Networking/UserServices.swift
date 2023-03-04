//
//  UserServices.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/03/2023.
//

import Foundation
import Moya

enum UserServices {
    case getUsers
    case getAlbums(userId : Int)
    case getPhotos(albumId : Int)
}

extension UserServices : TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .getUsers  : return "/users"
        case .getAlbums : return "/albums"
        case .getPhotos : return "/photos"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
        case .getUsers : return .requestPlain
        case .getAlbums(userId: let userId) :
            return .requestParameters(parameters: ["userId" : userId], encoding: URLEncoding.default)
            
            
        case .getPhotos(albumId: let albumId) :
            return .requestParameters(parameters: ["albumId" : albumId], encoding: URLEncoding.default)

        }
    }

    var headers: [String : String]?{
        return ["Content-Typer" :"application/json"]
    }


}
