//
//  AdaptivePresentation.swift
//  AdaptivityDemo
//
//  Created by BJ Homer on 6/16/15.
//  Copyright © 2015 BJ Homer. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showHeroImageForName(name: String) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("detail")
            as! DetailViewController
        
        controller.imageName = name
        
        if canShowInDetailPane() {
            showDetailViewController(controller, sender: nil)
        }
        else {
            showViewController(controller, sender: nil)
        }
    }
    
    
    func canShowInDetailPane() -> Bool {
        if let target = targetViewControllerForAction("canShowInDetailPane", sender: nil) {
            return target.canShowInDetailPane()
        }
        return false
    }
}

extension UISplitViewController {
    override func canShowInDetailPane() -> Bool {
        return collapsed == false
    }
}