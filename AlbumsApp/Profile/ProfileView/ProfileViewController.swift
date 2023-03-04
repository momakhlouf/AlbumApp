//
//  ProfileViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit
import Combine
import Moya
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userView: UIView!
    
    let userViewModel = UsersViewModel()
    let albumViewModel = AlbumsViewModel()
 
    
    var cancellable = Set<AnyCancellable>()
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    
    @IBOutlet weak var albumTableView: UITableView! {
        didSet{
            albumTableView.delegate = self
            albumTableView.dataSource = self
            albumTableView.register(UINib(nibName: "AlbumsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        self.title = "Profile"
        userView.makeCornerRauisView()
        fetchUsers()
        fetchAlbums()
        
//        provider.$users
//            .sink { completion in
//                print("comp\(completion)")
//            } receiveValue: { [weak self] newUsers in
//                print("newUsersss\(newUsers)")
//            }
//            .store(in: &cancellable)

    
        
    }

    
    //MARK: FETCH USER FROM VIEW MODEL USING COMBINE
    func fetchUsers(){
        userViewModel.getRandomUser()
        userViewModel.$user
            .sink { [weak self] randomUser in
                self?.albumTableView.reloadData()
//                let randomUser = returnedUsers.randomElement()
//                self?.randomUserID = randomUser?.id ?? 1
                //TO MAKE AN ICON WITHIN LABEL.
                self?.albumViewModel.getAlbums(user: randomUser ?? UserModel(id: 1, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipcode: ""), phone: "", website: ""))

                self?.userName.addLeading(image: UIImage(systemName: "person.fill")!, text: "  \(randomUser?.name ?? "")")
                self?.userAddress.addLeading(image: UIImage(systemName: "house.fill")!, text: " \(randomUser?.address.city ?? ""), \(randomUser?.address.street ?? "")")
                // self?.userName.text = randomUser?.name
                //self?.userAddress.text = "\(randomUser?.address.city ?? ""), \(randomUser?.address.street ?? "")"
            }
            .store(in: &cancellable)
    }
    
    func fetchAlbums(){
        albumViewModel.$albums
            .sink { [weak self] returnedAlbums in
                self?.albumTableView.reloadData()
            }
            .store(in: &cancellable)
    }
}



//MARK: USER ALBUMS TABLEVIEW DELEGATE & DATA SOURCE
extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albumViewModel.albums.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        cell.selectionStyle = .none
        albumViewModel.$albums
            .sink { albums  in
                cell.configureCell(with: albums[indexPath.row])
            }
            .store(in: &cancellable)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetailsVC = AlbumsScreenViewController()
        navigationController?.pushViewController(albumDetailsVC, animated: true)

        //        albumViewModel.$albums
        //            .sink { [weak self] album in
        //                albumDetailsVC.
        //            }
    }
    
}



