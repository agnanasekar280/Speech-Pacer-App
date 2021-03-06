//
//  ChooseTimerViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/11/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import UIKit
import UserNotifications

class ChooseTimerViewController: UITableViewController {
    
    var timer: Timesaver?
    
    var timers = [Timesaver](){
        didSet {
            tableView.reloadData()
        }
    }
    
    var minutes: Int = 0
    var notificationOneMinutes: Int = 0
    var notificationTwoMinutes: Int = 0
    
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        self.timers = CoreDataHelper.retrieveTimers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTimersTableViewCell", for: indexPath) as! ListTimersTableViewCell
        
        let row = indexPath.row
        let timer = timers[row]
        cell.timerTitleLabel.text = timer.title
        cell.timerTimeLabel.text = timer.time
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataHelper.delete(timer: timers[indexPath.row])
            timers = CoreDataHelper.retrieveTimers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timers = CoreDataHelper.retrieveTimers()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.black,
             NSFontAttributeName: UIFont(name: "Avenir", size: 21)!]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayRealTimer" {
                let realTimerViewController = segue.destination as! RealTimerViewController
                let indexPath = tableView.indexPathForSelectedRow!
                let timer = timers[indexPath.row]
                
                realTimerViewController.speechTime = Int(timer.minutes)
                realTimerViewController.notificationOneTime = Int(timer.notificationOneMinutes)
                realTimerViewController.notificationTwoTime = Int(timer.notificationTwoMinutes)
                realTimerViewController.notificationLabel.text = timer.notificationTitle
                realTimerViewController.secondNotificationLabel.text = timer.notificationTwoTitle
                realTimerViewController.secondNotification = timer.title!
            }
            
        }
    }
    
}
