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
    var filteredPhoto : [PhotoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Albums"
        searchBarConfigure()
        getPhotos()
    }
    
    func getPhotos(){
        photosViewModel.$photos
            .sink { [weak self] returnedPhotos in
                self?.filteredPhoto = returnedPhotos
                self?.imagesCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}


//MARK: PHOTOS COLLECTION View
extension AlbumsScreenViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPhoto.count  // photosViewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
        cell.configureCell(photo: filteredPhoto[indexPath.row])
        
        //        photosViewModel.$photos
        //            .sink { photos in
        //                cell.configureCell(photo: photos[indexPath.row])
        //            }
        //            .store(in: &cancellable)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
        let imageVC = ImageViewerViewController()
        imageVC.imageUrl =  filteredPhoto[indexPath.row].thumbnailUrl
        navigationController?.pushViewController(imageVC, animated: true)

        
      //  let imageViewer = ImageViewerViewController()
        //        photosViewModel.$photos
        //            .sink { photos in
        //              //  imageViewer.albumImage = cell.albumImageView
        //            }
        //            .store(in: &cancellable)
      //  navigationController?.pushViewController(imageViewer, animated: true)
        
    }
    
    
    
}

//MARK: SEARCHBAR DELEGATE
extension AlbumsScreenViewController : UISearchBarDelegate {
    
    
    func searchBarConfigure(){
        searchController.loadViewIfNeeded()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search by title here..."
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPhoto = []
        if searchText == "" {
            filteredPhoto = photosViewModel.photos
        }
        
        for photo in photosViewModel.photos {
            if photo.title.uppercased().contains(searchText.uppercased()){
                filteredPhoto.append(photo)
            }
        }
        self.imagesCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredPhoto = photosViewModel.photos
        
        imagesCollectionView.reloadData()
    }
}

//MARK: COLLECTION VIEW LAYOUT
extension AlbumsScreenViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (collectionView.frame.width  / 3) - 6, height: (collectionView.frame.width  / 3) - 6)
    }
    
}

