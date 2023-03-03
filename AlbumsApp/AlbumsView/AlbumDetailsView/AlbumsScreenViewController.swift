//
//  AlbumsScreenViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit

class AlbumsScreenViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!{
        didSet{
            imagesCollectionView.dataSource = self
            imagesCollectionView.delegate = self
            imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.loadViewIfNeeded()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "write a .. here..."

        // Do any additional setup after loading the view.
    }



}

extension AlbumsScreenViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
        cell.albumImageView.image = UIImage(systemName: "heart")
        return cell
        
    }
    
    
}


extension AlbumsScreenViewController : UISearchBarDelegate {
    
}


extension AlbumsScreenViewController : UICollectionViewDelegateFlowLayout {
//            func collectionView(_ collectionView: UICollectionView,
//                                layout collectionViewLayout: UICollectionViewLayout,
//                                sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//            }

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
