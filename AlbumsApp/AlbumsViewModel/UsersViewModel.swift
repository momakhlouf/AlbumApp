//
//  UsersViewModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Combine

class UsersViewModel : ObservableObject {
    
    let service = UserService.instance
    @Published var users : [UserModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
    init(){

    }
    
    func getUsers(){
        service.$users
            .sink { [weak self] returnedUsers in
                self?.users = returnedUsers
            }
            .store(in: &cancellable)
    }
}
