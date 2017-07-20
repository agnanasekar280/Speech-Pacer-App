//
//  RealTimerViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/18/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import UIKit
import UserNotifications

class RealTimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var speechTime: Int = 0
    
    var seconds: Int = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
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
        seconds = 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.setTitle("Pause", for: .normal)
        self.resumeTapped = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    func registerLocal() {
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("Uh oh")
            }
        }
    }
    
    func updateTimer() {
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        if seconds < 1 {
            let content = UNMutableNotificationContent()
            content.title = "Time's Up!"
            content.body = "You're done with your speech!"
            content.categoryIdentifier = "time"
            content.badge = 1
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = UNNotificationSound.default()
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            center.add(request)
            
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
        // Do any additional setup after loading the view.
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
