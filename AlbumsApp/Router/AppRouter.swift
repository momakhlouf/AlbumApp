//
//  AppCoordinator.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 05/03/2023.
//

import UIKit

class AppRouter {
    static func createProfileScene() -> UIViewController {
        let viewModel = ProfileViewModel()
        return ProfileViewController(viewModel: viewModel)
    }

    static func createAlbumsScene(albumId: Int) -> UIViewController {
        let viewModel = AlbumDetailsViewModel(albumId: albumId)
        return AlbumsDetailsViewController(viewModel: viewModel)
    }
}
