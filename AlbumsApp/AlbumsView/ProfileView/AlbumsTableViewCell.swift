//
//  AlbumsTableViewCell.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    @IBOutlet weak var albumName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with album : AlbumModel){
        albumName.text = album.title
    }
//    
  //  func configureCell(with user : UserModel){
//        albumName.text = user.name
//    }
//
    
    
    
     
}
