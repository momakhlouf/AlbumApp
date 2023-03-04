//
//  AlbumService.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Combine

class AlbumService{
    
    static let instance = AlbumService()
    
    @Published var albums : [AlbumModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
//    private init(){
//  getAlbums()
//    }
       
    
    func getAlbums(of user : UserModel){
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(user.id)/albums"){
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap { data, response in
                    guard
                        let response = response as? HTTPURLResponse,
                        response.statusCode >= 200 && response.statusCode < 300 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: [AlbumModel].self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion{
                    case .finished : break
                    case .failure(let error) :
                        DispatchQueue.main.async {
                            Alert.displayAlert(title: "Error", message: error.localizedDescription)
                        }
                    }
                } receiveValue: { [weak self] returnedAlbums in
                    self?.albums = returnedAlbums

                }
                .store(in: &cancellable)

        }
            
    }
    
}
