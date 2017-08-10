//
//  AboutViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 8/9/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var meImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meImageView.setRounded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
