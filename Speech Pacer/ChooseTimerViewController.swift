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
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayRealTimer" {
                let realTimerViewController = segue.destination as! RealTimerViewController
                let indexPath = tableView.indexPathForSelectedRow!
                let timer = timers[indexPath.row]
                realTimerViewController.speechTime = minutes
            }
            
        }
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
