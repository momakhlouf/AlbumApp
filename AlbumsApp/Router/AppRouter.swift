//
//  AppCoordinator.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 05/03/2023.
//

import UIKit

class AppRouter {
    static func createProfileScene() -> UIViewController {
        let viewModel = UsersViewModel()
        return ProfileViewController(viewModel: viewModel)
    }

    static func createAlbumsScene(albumId: Int) -> UIViewController {
        let viewModel = PhotosViewModel(albumId: albumId)
        return AlbumsDetailsViewController(viewModel: viewModel)
    }
}
