//
//  ViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit
import CombineMoya

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func toprofile(_ sender: Any) {
        let profile = ProfileViewController()
        navigationController?.pushViewController(profile, animated: true)
    }
    
}

