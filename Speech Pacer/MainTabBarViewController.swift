//
//  MainTabBarViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/11/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    var desiredIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = desiredIndex
    }
}

//extension MainTabBarController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController.tabBarItem.tag == 1 {
//            return false
//        }
//        return true
//    }
//}
