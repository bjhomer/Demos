//
//  AdaptiveDismissal.swift
//  AdaptivityDemo
//
//  Created by BJ Homer on 6/16/15.
//  Copyright © 2015 BJ Homer. All rights reserved.
//

import UIKit


extension UIViewController {
    func hasVisibleNavigationBar(withSender sender: AnyObject?) -> Bool {
        if let target =
            targetViewControllerForAction("hasVisibleNavigationBarWithSender:", sender: sender)
        {
            return target.hasVisibleNavigationBar(withSender: sender)
        }
        return false
    }
}

extension UINavigationController {
    override func hasVisibleNavigationBar(withSender sender: AnyObject?) -> Bool {
        return navigationBarHidden == false
    }
}




















extension UIViewController {
    func dismissAdaptively(controller: UIViewController? = nil) {
        if let target = targetViewControllerForAction("dismissAdaptively:", sender: nil) {
            target.dismissAdaptively(self)
        }
        else if let presenter = presentingViewController {
            presenter.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            print("Couldn't figure out a way to dismiss this controller. Sorry")
        }
    }
}

extension UINavigationController {
    override func dismissAdaptively(controller: UIViewController?) {
        popViewControllerAnimated(true)
    }
}

extension UISplitViewController {
    override func dismissAdaptively(optController: UIViewController?) {
        guard let controller = optController else {
            parentViewController?.dismissAdaptively()
            return
        }
        
        let optIndex = viewControllers.indexOf(controller)
        switch optIndex {
        case .None:
            parentViewController?.dismissAdaptively(controller)
        case .Some(let index):
            let controller = UIViewController()
            controller.view.backgroundColor = UIColor.whiteColor()
            viewControllers[index] = controller
        }
        
    }
}

