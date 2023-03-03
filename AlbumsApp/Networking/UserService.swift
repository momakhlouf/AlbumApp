//
//  UserService.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import Foundation
import Moya
import Combine

class UserService {
    
    static let instance = UserService()
    
    @Published var users : [UserModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
    private init() {
        getUsers()
    }
    
    func getUsers(){
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users"){
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap { data , response in
                    guard
                        let response = response as? HTTPURLResponse,
                        response.statusCode >= 200 && response.statusCode < 300 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: [UserModel].self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion{
                    case .finished : break
                    case .failure(let error) : print(error)
                    }
                } receiveValue: { [weak self] returnedUsers in
                    self?.users = returnedUsers
                  //  print("service \(returnedUsers)")
                }
                .store(in: &cancellable)
        }
    }
}


//enum UserService {
//    case readUsers
//}
//extension UserService : TargetType {
//    var baseURL: URL {
//        return URL(string: "https://jsonplaceholder.typicode.com")!
//    }
//     
//    var path: String {
//        return "/users"
//    }
//    
//    var method: Moya.Method {
//        return .get
//    }
//    
//    var task: Moya.Task {
//        return .requestPlain
//    }
//    
//    var headers: [String : String]?{
//     return ["",""]
//    }
//    
//    
//}
