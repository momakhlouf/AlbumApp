//
//  UsersViewModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Combine
import Moya


class UsersViewModel : ObservableObject {
    let service = UserService.instance

  //  @Published var users : [UserModel] = []
    let provider = MoyaProvider<UserServices>()

    @Published var user : UserModel? = nil
    
    var cancellable = Set<AnyCancellable>()
    
//    init(){
//     getUser()
//    }
    
    
    func getRandomUser(){
        provider.requestPublisher(.getUsers)
            .receive(on: DispatchQueue.main)
            .tryMap({  response in
                response.data
            })
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished : break
                case .failure(let error) :
                    DispatchQueue.main.async {
                        Alert.displayAlert(title: "Error", message: error.localizedDescription )
                    }
                }
            }, receiveValue: { randomUser in
                self.user = randomUser.randomElement()
            })
            .store(in: &cancellable)
    }


//    func getUser(){
//        service.$user
//            .sink { completion in
//                switch completion {
//                case .failure(let error) :
//                    DispatchQueue.main.async {
//                        Alert.displayAlert(title: "Error", message: error.localizedDescription)
//                    }
//                case .finished : break
//                }
//            } receiveValue: { [weak self] randomUser in
//                
//                self?.user = randomUser
//                
//
//                
//            }
//            .store(in: &cancellable)
//    }
    
//    func getUsers(){
//
//        service.$users
//            .sink { completion in
//                switch completion {
//                case .failure(let error) :
//                    DispatchQueue.main.async {
//                        Alert.displayAlert(title: "Error", message: error.localizedDescription)
//                    }
//                case .finished : break
//                }
//            } receiveValue: { [weak self] returnedUsers in
//
//                self?.users = returnedUsers
//
//            }
//            .store(in: &cancellable)
//    }
}


