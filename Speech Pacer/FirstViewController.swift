//
//  FirstViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/10/17.
//  Copyright © 2017 The Girl Code. All rights reserved.

// hi my name is aditi

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var setTimerButton: UIButton!
    @IBOutlet weak var chooseTimerButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    var currentIndex: Int = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMain" {
            let vc = segue.destination as! MainTabBarController
            vc.desiredIndex = currentIndex
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setTimerButtonTapped(_ sender: UIButton) {
        currentIndex = 0
        performSegue(withIdentifier: "toMain", sender: nil)
    }
    
  /*  @IBAction func chooseTimerButtonTapped(_ sender: UIButton) {
        currentIndex = 1
        performSegue(withIdentifier: "toMain", sender: nil)
    }
 */
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        currentIndex = 1
        performSegue(withIdentifier: "toMain", sender: nil)
    }
    
}
