//
//  AlbumsTableViewCell.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var albumName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // setView()
        cellView.makeCornerRauisView()
        cellView.layer.cornerRadius = 10
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
    func configureCell(with album : AlbumModel){
        albumName.text = album.title
    }
}

