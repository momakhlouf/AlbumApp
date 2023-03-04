//
//  PhotosViewModel.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Combine
class PhotosViewModel : ObservableObject {
    
    @Published var photos : [PhotoModel] = []

    let service = PhotoService.instance
    var cancellable = Set<AnyCancellable>()
    
    
     init(){
        getPhotos()
     }
    
    func getPhotos(){
        service.getPhotos()
        service.$photos
            .sink { [weak self] returnedPhotos in
                self?.photos = returnedPhotos
            }
            .store(in: &cancellable)
    }
}
