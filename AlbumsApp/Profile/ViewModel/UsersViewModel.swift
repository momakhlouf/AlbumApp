//
//  UsersViewModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Combine
import Moya
import CombineMoya

class UsersViewModel : ObservableObject {
    
    let provider = MoyaProvider<NetworkClient>()
    
    // TODO: must be private
    @Published  var user : UserModel? = nil
    @Published  var albums : [AlbumModel] = []
    let errorPublisher = PassthroughSubject<Error, Never>()
    
    var cancellables = Set<AnyCancellable>()

    func viewDidLoad() {
        getUser()
    }
    
    //MARK: GET USER
    func getUser(){
        provider.requestPublisher(.getUsers)
            .subscribe(on: DispatchQueue.global())
            .tryMap { $0.data }
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .finished : break
                case .failure(let error) :
                    self?.errorPublisher.send(error)
                }
            }, receiveValue: {[weak self] randomUser in
                self?.user = randomUser.randomElement()
                self?.getAlbum(id: self?.user?.id ?? 0)
            })
            .store(in: &cancellables)
        
    }
    
    //MARK: GET USER ALBUM
    func getAlbum( id : Int){
        provider.requestPublisher(.getAlbums(userId: id))
            .subscribe(on: DispatchQueue.global())
            .tryMap { $0.data }
            .decode(type: [AlbumModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .finished : break
                case .failure(let error) :
                    self?.errorPublisher.send(error)
                }
            }, receiveValue: {[weak self] returnedAlbum in
                self?.albums = returnedAlbum
            })
            .store(in: &cancellables)
    }
    
}

