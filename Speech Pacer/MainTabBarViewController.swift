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


