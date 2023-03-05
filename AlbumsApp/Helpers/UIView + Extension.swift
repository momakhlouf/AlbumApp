//
//  Extensions.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import UIKit


extension UIView{
    
    func makeShadow(){
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.gray.cgColor
        layer.masksToBounds = false
    }
}
