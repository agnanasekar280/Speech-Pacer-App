//
//  SetNewTimerViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/11/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
import UIKit

class SetNewTimerViewController: UIViewController {
    
    var timer: Timesaver?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var timerTextField: UITextField!
    
    @IBOutlet weak var notificationOneTextField: UITextField!
    
    @IBOutlet weak var notificationOneTimeTextField: UITextField!
    
    @IBOutlet weak var notificationTwoTextField: UITextField!
    
    @IBOutlet weak var notificationTwoTimeTextField: UITextField!

    var minutes: Int = 0
    var notificationOneMinutes: Int = 0
    var notificationTwoMinutes: Int = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("Cancel button tapped")
            } else if identifier == "save" {
                print("Save button tapped")
                
                let timer = self.timer ?? CoreDataHelper.newTimer()
                timer.title = titleTextField.text ?? ""
                timer.time = timerTextField.text ?? ""
                timer.notificationTitle = notificationOneTextField.text ?? ""
                timer.notificationTwoTitle = notificationTwoTextField.text ?? ""
                timer.notificationTime = notificationOneTimeTextField.text ?? ""
                timer.notificationTwoTime = notificationTwoTimeTextField.text ?? ""
                timer.minutes = Int16(minutes)
                timer.notificationOneMinutes = Int16(notificationOneMinutes)
                timer.notificationTwoMinutes = Int16(notificationTwoMinutes)
                
                
                let listTimersTableViewController = segue.destination as! ChooseTimerViewController
                listTimersTableViewController.timers.append(timer)
                listTimersTableViewController.minutes = minutes
                print(minutes)
                CoreDataHelper.saveTimer()
            }
        }
    }
    
    
    /*    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let listTimersTableViewController = segue.destination as! ChooseTimerViewController
     if let identifier = segue.identifier {
     if identifier == "cancel" {
     print("Cancel button tapped")
     } else if identifier == "save" {
     if let timer = timer {
     timer.title = titleTextField.text ?? ""
     listTimersTableViewController.tableView.reloadData()
     } else {
     let newTimer = setTime()
     newTimer.title = titleTextField.text ?? ""
     newTimer.time = Date()
     listTimersTableViewController.timers.append(newTimer)
     }
     }
     }
     }
     */
    @IBAction func save(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backToMain", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timerPicker = UIDatePicker()
        timerPicker.datePickerMode = UIDatePickerMode.countDownTimer
        timerTextField.inputView = timerPicker
        timerPicker.addTarget(self, action: #selector(SetNewTimerViewController.timerPickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        
        
        let notificationOneTimerPicker = UIDatePicker()
        notificationOneTimerPicker.datePickerMode = UIDatePickerMode.countDownTimer
        notificationOneTimeTextField.inputView = notificationOneTimerPicker
        notificationOneTimerPicker.addTarget(self, action: #selector(SetNewTimerViewController.notificationOneTimerPickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        

        
        let notificationTwoTimerPicker = UIDatePicker()
        notificationTwoTimerPicker.datePickerMode = UIDatePickerMode.countDownTimer
        notificationTwoTimerPicker.addTarget(self, action: #selector(SetNewTimerViewController.notificationTwoTimerPickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        notificationTwoTimeTextField.inputView = notificationTwoTimerPicker
    }

    
    func timerPickerValueChanged(sender: UIDatePicker){
        minutes = Int(sender.countDownDuration / 60)
        if (sender.countDownDuration / 60) == 1 {
            timerTextField.text = String(Int(sender.countDownDuration / 60)) + " minute"

        }else{
            timerTextField.text = String(Int(sender.countDownDuration / 60)) + " minutes"
        }
    }

    
    func notificationOneTimerPickerValueChanged(sender: UIDatePicker){
        notificationOneMinutes = Int(sender.countDownDuration / 60)
        if (sender.countDownDuration / 60) == 1 {
            notificationOneTimeTextField.text = String(Int(sender.countDownDuration / 60)) + " minute"
        } else {
            notificationOneTimeTextField.text = String(Int(sender.countDownDuration / 60)) + " minutes"
        }
        
    }
    
    func notificationTwoTimerPickerValueChanged(sender: UIDatePicker){
        notificationTwoMinutes = Int(sender.countDownDuration / 60)
        if (sender.countDownDuration / 60) == 1 {
            notificationTwoTimeTextField.text = String(Int(sender.countDownDuration / 60)) + " minute"
        }else{
            notificationTwoTimeTextField.text = String(Int(sender.countDownDuration / 60)) + " minutes"
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
