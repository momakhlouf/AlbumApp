//
//  AlbumsViewModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Combine

class AlbumsViewModel : ObservableObject {
    
    let service = AlbumService.instance

    @Published var albums : [AlbumModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
    init(){
        
    }
    
    
    func getAlbums(){
        service.$albums
            .sink { completion in
                switch completion {
                case .failure(let error)
                    : print("rrr\(error)")
                case .finished : break
                }
            } receiveValue: { [weak self]  returnedAlbums in
                self?.albums = returnedAlbums
                    print("vm \(returnedAlbums)")

            }
            .store(in: &cancellable)

//        service.$albums
//            .sink { [weak self] returnedAlbums in
//                self?.albums = returnedAlbums
//                print("vm \(returnedAlbums)")
//            }
//            .store(in: &cancellable)
    }
}
