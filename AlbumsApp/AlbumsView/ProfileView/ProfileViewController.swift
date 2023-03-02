//
//  ProfileViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    
    @IBOutlet weak var albumTableView: UITableView! {
        didSet{
            albumTableView.delegate = self
            albumTableView.dataSource = self
            albumTableView.register(UINib(nibName: "AlbumsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        userName.text = "hi"
        userAddress.text = "ya raaaab"
   
    }

}


extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        cell.albumName.text = "hello"
        return cell
    }
    
    
}
