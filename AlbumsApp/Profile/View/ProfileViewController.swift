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
    
    let viewModel: ProfileViewModel
    var cancellable = Set<AnyCancellable>()

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    
    @IBOutlet weak var albumTableView: UITableView!

    public init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.title = "Profile"
        userView.makeShadow()
        setupTableView()
        setupViewModelBindings()
        viewModel.viewDidLoad()
    }
}

//MARK: Configurations
private extension ProfileViewController {
    func setupTableView() {
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.register(UINib(nibName: "AlbumsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

//MARK: setup ViewModel Bindings
private extension ProfileViewController {
    func setupViewModelBindings() {
        viewModel.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] randomUser in
                guard let self,
                      let user = randomUser else { return }
                self.updateUserView(user: user) }
            .store(in: &cancellable)

        viewModel.$albums
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.albumTableView.reloadData() }
            .store(in: &cancellable)

        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showAlert(title: "error", message: error.localizedDescription)
            }
            .store(in: &cancellable)
    }

    func updateUserView(user: UserModel) {
        userName.text = user.name ?? ""
        userAddress.text = " \(user.address?.city ?? ""), \(user.address?.street ?? "")"
    }
}


//MARK: USER ALBUMS TABLEVIEW DELEGATE & DATA SOURCE
extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  viewModel.getCountOfAlbum()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        cell.selectionStyle = .none
        cell.configureCell(with: viewModel.getDataOfAlbum()[indexPath.row])
    
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row].id ?? 0
        let albumDetailsVC = AppRouter.createAlbumsScene(albumId: album)
        navigationController?.pushViewController(albumDetailsVC, animated: true)
    
    }
}
