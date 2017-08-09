//
//  RealTimerViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/18/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import UIKit
import AudioToolbox


let notificationKey = "com.color"

class RealTimerViewController: UIViewController {
    
    @IBOutlet weak var speechTitleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var notificationView: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet var secondNotificationView: UIView!
    @IBOutlet weak var secondNotificationLabel: UILabel!
    @IBOutlet var finalNotificationView: UIView!
    
    var secondNotification = ""
    var speechTime: Int = 0
    var notificationOneTime: Int = 0
    var notificationTwoTime: Int = 0
    
    var seconds: Int = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    func changeColor(_ notification: NSNotification) {
        if let color = notification.userInfo?["color"] as? UIColor {
            notificationView.backgroundColor = color
            secondNotificationView.backgroundColor = color
        } else {
            notificationView.backgroundColor = UIColor.darkGray
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(RealTimerViewController.updateTimer)), userInfo: nil, repeats: true)
        pauseButton.isEnabled = true
        isTimerRunning = true
    }
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    @IBAction func startButton(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume",for: .normal)
            
        } else {
            runTimer()
            isTimerRunning = true
            self.resumeTapped = false
            self.pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60 * speechTime
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.setTitle("Pause", for: .normal)
        self.resumeTapped = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    func updateTimer() {
        
        if seconds == 60 * notificationOneTime {
            animateIn()
        }
        
        if seconds == 60 * notificationTwoTime {
            animateInAgain()
        }
        
        if seconds == 0 {
            animateInFinal()
        }
                
        if notificationView.alpha == 1 {
            animateOut()
        }
        
        if secondNotificationView.alpha == 1{
            animateOutAgain()
        }
        
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate "time's up!"
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayRealTimer" {
                print("Table view cell tapped")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds =  60 * speechTime
        pauseButton.isEnabled = false
        print(speechTime)
        timerLabel.text = timeString(time: TimeInterval(seconds))
        notificationView.layer.cornerRadius = 5
        speechTitleLabel.text = secondNotification
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeColor(_:)), name: NSNotification.Name(notificationKey), object: nil)
        
    }
    
    func animateIn() {
        self.view.addSubview(notificationView)
        notificationView.center = self.view.center
        
       // notificationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        notificationView.alpha = 0
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        UIView.animate(withDuration: 0.4) {
            self.notificationView.alpha = 1
            self.notificationView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateInAgain() {
        self.view.addSubview(secondNotificationView)
        secondNotificationView.center = self.view.center
        
        //secondNotificationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        secondNotificationView.alpha = 0
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        UIView.animate(withDuration: 0.4) {
            self.secondNotificationView.alpha = 1
            self.secondNotificationView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateInFinal() {
        self.view.addSubview(finalNotificationView)
        finalNotificationView.center = self.view.center
        
        //secondNotificationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        finalNotificationView.alpha = 0
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) 
        
        UIView.animate(withDuration: 0.4) {
            self.finalNotificationView.alpha = 1
            self.finalNotificationView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateOutAgain() {
        UIView.animate(withDuration: 0.3, delay: 4, options: [], animations: {
            //self.secondNotificationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.secondNotificationView.alpha = 0
        }) { (success: Bool) in
            self.secondNotificationView.removeFromSuperview()
        }
    }


    
    func animateOut() {
        UIView.animate(withDuration: 0.3, delay: 4, options: [], animations: {
         //   self.notificationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.notificationView.alpha = 0
        }) { (success: Bool) in
            self.notificationView.removeFromSuperview()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
