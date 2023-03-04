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
    @Published var user : UserModel? = nil 

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
                    case .failure(let error) :
                        DispatchQueue.main.async {
                            Alert.displayAlert(title: "Error", message: error.localizedDescription)
                        }
                    }
                } receiveValue: { [weak self] returnedUsers in
                    // self?.users = returnedUsers
                    self?.user = returnedUsers.randomElement()!
                }
                .store(in: &cancellable)
        }
    }
}


