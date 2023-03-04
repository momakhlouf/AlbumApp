//
//  PhotoService.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import Combine

class PhotoService{
   
     static let instance = PhotoService()
    
    @Published var photos : [PhotoModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
//    private init(){
//        getPhotos()
//    }
    
    func getPhotos(){
        if let url = URL(string: "https://jsonplaceholder.typicode.com/albums/1/photos"){
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
                .decode(type: [PhotoModel].self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion{
                    case .finished : break
                    case .failure(let error) :
                        DispatchQueue.main.async {
                            Alert.displayAlert(title: "Error", message: error.localizedDescription)
                        }
                    }
                } receiveValue: { [weak self] returnedPhotos in
                    self?.photos = returnedPhotos
                }
                .store(in: &cancellable)

        }
    }
}
