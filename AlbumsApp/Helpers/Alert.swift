//
//  Alert.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/03/2023.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
