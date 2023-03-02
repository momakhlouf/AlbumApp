//
//  UserService.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import Foundation
import Moya


enum UserService {
    case readUsers
}
extension UserService : TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
     
    var path: String {
        return "/users"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]?{
     return ["",""]
    }
    
    
}
