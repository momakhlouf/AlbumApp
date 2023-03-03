//
//  ImageViewerViewController.swift
//  AlbumsApp
//
//  Created by Mohamed Makhlouf Ahmed on 03/03/2023.
//

import UIKit

class ImageViewerViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }

    @IBOutlet weak var albumImage: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   albumImage.image = UIImage(named: "heart")
        setShareButton()
    
    }

    func setShareButton(){
        let shareButton = UIBarButtonItem()
        shareButton.image = UIImage(systemName: "square.and.arrow.up.fill")
        shareButton.action = #selector(shareImage)
        shareButton.target = self
        navigationItem.rightBarButtonItems = [shareButton]
    }
        
    @objc func shareImage(){
        
        let firstActivityItem = "Share your photo with "
        if let image = albumImage.image {
            // let image : UIImage =  albumImage.image
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, image], applicationActivities: nil)
        
        
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
}

}

extension ImageViewerViewController : UIScrollViewDelegate {
 
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return albumImage
    }
}


