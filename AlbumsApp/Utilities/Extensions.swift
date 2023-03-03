//
//  Extensions.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import Foundation
import UIKit

extension UILabel {

    func addLeading(image: UIImage, text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let string = NSMutableAttributedString(string: text, attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
}


extension UIView{
    
    func makeCornerRauisView(){
        //let cornerRadius: CGFloat = 20
       // layer.cornerRadius = cornerRadius
        layer.masksToBounds = false

        layer.shadowRadius = 4
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.gray.cgColor
        layer.masksToBounds = false
    }
}


