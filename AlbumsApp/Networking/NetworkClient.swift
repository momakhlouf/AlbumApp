//
//  NetworkClient.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/03/2023.
//

import Foundation
import Moya

enum NetworkClient {
    case getUsers
    case getAlbums(userId : Int)
    case getPhotos(albumId : Int)
}

extension NetworkClient: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }

    var path: String {
        switch self {
        case .getUsers  : return "users"
        case .getAlbums : return "albums"
        case .getPhotos : return "photos"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .getAlbums(let userId):
            return .requestParameters(parameters: ["userId" : userId], encoding: URLEncoding.default)
        case .getPhotos(let albumId):
            return .requestParameters(parameters: ["albumId" : albumId], encoding: URLEncoding.default)

        }
    }

    var headers: [String : String]?{
        return ["Content-Typer" :"application/json"]
    }


}
