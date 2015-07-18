//
//  AdaptiveTabSwitching.swift
//  AdaptivityDemo
//
//  Created by BJ Homer on 6/18/15.
//  Copyright © 2015 BJ Homer. All rights reserved.
//

import UIKit

extension UIViewController {
    func showPinkController(withSender sender: AnyObject) {
        if let target =
            targetViewControllerForAction("showPinkControllerWithSender:", sender: sender)
        {
            target.showPinkController(withSender: sender)
        }
        else if let target = presentingViewController?.targetViewControllerForAction("showPinkControllerWithSender:", sender: sender)
        {
            dismissAdaptively()
            target.showPinkController(withSender: sender)
        }
    }
}

extension UITabBarController {
    override func showPinkController(withSender sender: AnyObject) {
        selectedIndex = 0
    }
}


extension UISplitViewController {
    override func showPinkController(withSender sender: AnyObject) {
        for controller in viewControllers {
            if let target = controller.targetViewControllerForAction("showPinkControllerWithSender:", sender: sender)
            {
                target.showPinkController(withSender: sender)
                return
            }
            
        }
    }
}