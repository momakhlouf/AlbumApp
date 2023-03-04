//
//  NetworkProvider.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Moya
import Combine
protocol UserProvider{
     
}

class UserProviderManager : UserProvider {
    @Published var users : [UserModel] = []

    var cancellable = Set<AnyCancellable>()
    private let provider = MoyaProvider<UserServices>()
    
    
//    func getUsers(){
//        provider.request(.getUsers){ result in
//            switch result {
//            case .failure(let error) : print(error)
//            case .success(let response) :
//                let data = response.data
//                let users =  try JSONDecoder().decode([UserModel].self, from: data)
//
//            }
//
//        }
         
        
        
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
//            .tryMap{ response in
//                guard
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//
//            }
//            //.tryMap([UserModel].self)
//            .decode(type: [UserModel].self, decoder: JSONDecoder())
//            .sink { completion in
//                switch completion{
//                case .finished : break
//                case .failure(let error) :
//                    DispatchQueue.main.async {
//                        Alert.displayAlert(title: "Error", message: error.localizedDescription)
//                    }
//                }
//            } receiveValue: { [weak self] newUsers in
//                self?.users = newUsers
//
//            }
//            .store(in: &cancellable)

            

    
    
    
    
    
//    func fetchData(){
//        provider.request(.getUsers) { result in
//            guard let self = self else {return}
//            switch result {
//            case .success(let response) :
//                
//            }
//            
//        }
    
//    provider.request(.getUsers) { (result) in
//        switch result {
//        case .success(let response) :
//            let json = try! JSONSerialization.jsonObject(with: response.data , options: [])
//            print("json ::\(json)")
//        case .failure(let error) : print(error)
//        }
//    }
           
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
//            .tryMap  { data , response in
//                guard
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
//            .decode(type: [UserModel].self, decoder: JSONDecoder())
//            .sink { completion in
//                switch completion{
//                case .finished : break
//                case .failure(let error) :
//                    DispatchQueue.main.async {
//                        Alert.displayAlert(title: "Error", message: error.localizedDescription)
//                    }
//                }
//            } receiveValue: { [weak self] returnedUser in
//
//            }
//            .store(in: &cancellable)

            
   // }
}

