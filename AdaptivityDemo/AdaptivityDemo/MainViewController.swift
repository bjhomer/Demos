//
//  ViewController.swift
//  AdaptivityDemo
//
//  Created by BJ Homer on 6/15/15.
//  Copyright © 2015 BJ Homer. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cook: UIButton!
    @IBOutlet weak var ive: UIButton!
    @IBOutlet weak var schiller: UIButton!
    @IBOutlet weak var federighi: UIButton!

    @IBAction func tappedThumbnail(sender: UIButton) {
        let imageName: String
        
        switch sender {
        case cook: imageName = "cook"
        case ive:  imageName = "ive"
        case schiller: imageName = "schiller"
        case federighi: imageName = "federighi"
        default: fatalError()
        }

        showHeroImageForName(imageName)
    }

}

