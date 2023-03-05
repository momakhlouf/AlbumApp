//
//  AlbumsScreenViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit
import Combine
import Kingfisher


class AlbumsDetailsViewController: UIViewController {
    
     
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var albumId : Int = 0
    var albumModel : AlbumModel?
    var subscription  : AnyCancellable?
    var cancellable = Set<AnyCancellable>()
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel: AlbumDetailsViewModel
    

    public init(viewModel: AlbumDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Albums"
  
        searchBarConfigure()
        setupViewModelBindings()
        setupCollectionView()
        viewModel.getPhotos()
    }
}


func setUpEmptyView(){
    
  
}

//MARK: Configurations
private extension AlbumsDetailsViewController {
    func setupCollectionView(){
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    }
}

//MARK: setup ViewModel Bindings
private extension AlbumsDetailsViewController {
    func setupViewModelBindings() {
        viewModel.$photos
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished : break
                case .failure(let error):
                    self?.showAlert(title: "error", message: error.localizedDescription)
                }
            }, receiveValue: { [weak self] _ in
                self?.imagesCollectionView.reloadData()
            })
            .store(in: &cancellable)
        
        viewModel.$filteredPhoto
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.imagesCollectionView.reloadData()
            }
            .store(in: &cancellable)

        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showAlert(title: "error", message: error.localizedDescription)
            }
            .store(in: &cancellable)
    }
}


//MARK: PHOTOS COLLECTION View
extension AlbumsDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func emptyCollectionView(){
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.getCountOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
        cell.configureCell(photo: viewModel.getDataOfPhotos()[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageVC = ImageViewerViewController()
        imageVC.imageUrl =  viewModel.filteredPhoto[indexPath.row].thumbnailUrl ?? ""
        navigationController?.pushViewController(imageVC, animated: true)
    }
}

//MARK: SEARCHBAR DELEGATE
extension AlbumsDetailsViewController : UISearchBarDelegate {
  
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
        viewModel.updateSearch(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.updateSearch(text: "")
    }
}

//MARK: COLLECTION VIEW LAYOUT
extension AlbumsDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (collectionView.frame.width  / 3) - 6, height: (collectionView.frame.width  / 3) - 6)
    }
    
}

