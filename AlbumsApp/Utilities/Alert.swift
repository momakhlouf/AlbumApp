//
//  Alert.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/03/2023.
//

import Foundation
import UIKit
class Alert {

    static func displayAlert(title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        //alert.view.tintColor = UIColor(hex: 0x1C1A26)
      //  self.present(alert, animated: true, completion: nil)

        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            fatalError("keyWindow has no rootViewController")
            return
        }

        viewController.present(alert, animated: true, completion: nil)
    }

}

extension UIViewController{
    func showAlertError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension UIViewController {
    func showAlertSheet(title:String, message:String,complition:@escaping (Bool)->Void){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let logOut = UIAlertAction(title: "Log out", style: .destructive) { _ in
            complition(true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            complition(false)
        }
        actionSheet.addAction(logOut)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
}
