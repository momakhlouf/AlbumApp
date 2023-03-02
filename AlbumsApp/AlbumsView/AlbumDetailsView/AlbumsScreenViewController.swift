//
//  AlbumsScreenViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/03/2023.
//

import UIKit

class AlbumsScreenViewController: UIViewController {


    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlbumsScreenViewController : UISearchBarDelegate {
    
}
