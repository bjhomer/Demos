//
//  DetailViewController.swift
//  AdaptivityDemo
//
//  Created by BJ Homer on 6/16/15.
//  Copyright © 2015 BJ Homer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    
    var imageName: String? {
        didSet { updateImage() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage()
        updateCloseButton()
    }
    
    private func updateImage() {
        guard let imageName = imageName else { return }
        let name = "big/\(imageName)"
        imageView?.image = UIImage(named: name)
    }
    
    private func updateCloseButton() {
        closeButton.hidden = hasVisibleNavigationBar(withSender: nil)
    }
    
    @IBAction func tappedCloseButton(sender: UIButton) {
        dismissAdaptively()
    }

    @IBAction func tappedShowPink(sender: AnyObject) {
        showPinkController(withSender: self)
    }
    
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        updateCloseButton()
    }
}
