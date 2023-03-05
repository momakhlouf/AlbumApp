//
//  ImageViewerViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import UIKit
import Kingfisher
class ImageViewerViewController: UIViewController {
    
    var imageUrl : String = ""
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var albumImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        albumImage.kf.setImage(with: URL(string: imageUrl ))
        setShareButton()
    }
}

//MARK: ZOOM IMAGE
extension ImageViewerViewController : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return albumImage
    }
}

//MARK: SHARE IMAGE
extension ImageViewerViewController {
    
    
    func setShareButton(){
        let shareButton = UIBarButtonItem()
        shareButton.image = UIImage(systemName: "square.and.arrow.up")
        shareButton.action = #selector(shareImage)
        shareButton.target = self
        navigationItem.rightBarButtonItems = [shareButton]
    }
    
    
    @objc func shareImage(){
        let title = "Share your photo with : "
        if let image = albumImage.image {
            let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [title , image], applicationActivities: nil)
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
        }
    }

}
