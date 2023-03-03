//
//  ImagesCollectionViewCell.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(photo : PhotoModel){
        albumImageView.kf.setImage(with: URL(string: photo.thumbnailUrl ))
        
    }

}
