//
//  AlbumsScreenViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit
import Combine
import Kingfisher

class AlbumsScreenViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!{
        didSet{
            imagesCollectionView.dataSource = self
            imagesCollectionView.delegate = self
            imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        }
    }
    var cancellable = Set<AnyCancellable>()
    let searchController = UISearchController(searchResultsController: nil)
    let photosViewModel = PhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarConfigure()


    }

    
    func getPhotos(){
        photosViewModel.$photos
            .sink { [weak self] _ in
                self?.imagesCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }

    
    
    func searchBarConfigure(){
        searchController.loadViewIfNeeded()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "write a .. here..."
    }

}


//MARK: PHOTOS COLLECTION View
extension AlbumsScreenViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
        
        photosViewModel.$photos
            .sink { photos in
                cell.configureCell(photo: photos[indexPath.row])
            }
            .store(in: &cancellable)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
        
         let imageViewer = ImageViewerViewController()
//        photosViewModel.$photos
//            .sink { photos in
//              //  imageViewer.albumImage = cell.albumImageView
//            }
//            .store(in: &cancellable)
        navigationController?.pushViewController(imageViewer, animated: true)

    }
    
    
}


extension AlbumsScreenViewController : UISearchBarDelegate {
    
}


extension AlbumsScreenViewController : UICollectionViewDelegateFlowLayout {

            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }

            func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }
        }
