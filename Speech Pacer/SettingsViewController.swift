//
//  SettingsViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/11/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    let colorArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBAction func sliderChanged(sender: AnyObject) {
        selectedColorView.backgroundColor = uiColorFromHex(rgbValue: colorArray[Int(slider.value)])
    }
    
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    @IBAction func chooseButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationKey), object: nil, userInfo: ["color": selectedColorView.backgroundColor!])
        let alert = UIAlertController(title: "Your color has been chosen!", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
