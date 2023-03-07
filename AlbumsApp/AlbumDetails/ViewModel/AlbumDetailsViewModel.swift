//
//  PhotosViewModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Combine
import Moya
import CombineMoya

class AlbumDetailsViewModel : ObservableObject {
    
    @Published  var isLoading : Bool = false
    @Published  var showEmptyView : Bool = false
    @Published  var photos : [PhotoModel] = []
    @Published  var filteredPhoto : [PhotoModel] = []
    let errorPublisher = PassthroughSubject<Error, Never>()
    
    var cancellable = Set<AnyCancellable>()
    
    private let provider = MoyaProvider<NetworkClient>()
    private let albumId: Int
    
    init(albumId: Int){
        self.albumId = albumId
    }
    
    
    
    func getCountOfPhotos() -> Int{
        return filteredPhoto.count
    }
    
    func getDataOfPhotos() -> [PhotoModel]{
        return filteredPhoto
    }
    
    
    
    func getPhotos(){
        isLoading = true
        provider.requestPublisher(.getPhotos(albumId: albumId))
            .subscribe(on: DispatchQueue.global())
            .tryMap { $0.data }
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: {[weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished : break
                case .failure(let error) :
                    self?.errorPublisher.send(error)
                }
            }, receiveValue: { response in
                self.photos = response
                self.filteredPhoto = response
            })
            .store(in: &cancellable)
    }
    
    func updateSearch(text: String) {
        if text.isEmpty {
            filteredPhoto = photos
        } else {
            filteredPhoto = photos.filter { ($0.title ?? "").lowercased().contains(text.lowercased())}
            
            if filteredPhoto.contains(where: { photo in
                photo.title != text
            }) {
                showEmptyView = false
            }else{
                showEmptyView = true
            }
            
        }
    }
    
    
}
