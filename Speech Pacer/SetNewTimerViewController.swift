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
    
    @IBAction func timerTextFieldTapped(_ sender: UITextField) {
        let timerPicker = UIDatePicker()
        var dateComp: NSDateComponents = NSDateComponents()
        dateComp.hour = 0
        dateComp.minute = 1
        dateComp.timeZone = NSTimeZone.system
        var calendar: NSCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        var date = calendar.date(from: dateComp as DateComponents)!
        timerPicker.datePickerMode = UIDatePickerMode.countDownTimer
        
        sender.inputView = timerPicker
        timerPicker.setDate(date as Date, animated: true)

        timerPicker.addTarget(self, action: #selector(timerPickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }

    @IBAction func notificationOneTimerTextField(_ sender: UITextField) {
        let notificationOneTimerPicker = UIDatePicker()
        var dateComps: NSDateComponents = NSDateComponents()
        dateComps.hour = 0
        dateComps.minute = 1
        dateComps.timeZone = NSTimeZone.system
        var calendar: NSCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        var date = calendar.date(from: dateComps as DateComponents)!
        notificationOneTimerPicker.datePickerMode = UIDatePickerMode.countDownTimer
        
        notificationOneTimeTextField.inputView = notificationOneTimerPicker
        notificationOneTimerPicker.setDate(date as Date, animated: true)
        
        notificationOneTimerPicker.addTarget(self, action: #selector(notificationOneTimerPickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    
    @IBAction func notificationTwoTimerPicker(_ sender: UITextField) {
        let notificationTwoTimerPicker = UIDatePicker()
        var dateComponent: NSDateComponents = NSDateComponents()
        dateComponent.hour = 0
        dateComponent.minute = 1
        dateComponent.timeZone = NSTimeZone.system
        var calendar: NSCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        var date = calendar.date(from: dateComponent as DateComponents)!
        notificationTwoTimerPicker.datePickerMode = UIDatePickerMode.countDownTimer
        
        notificationTwoTimeTextField.inputView = notificationTwoTimerPicker
        notificationTwoTimerPicker.setDate(date as Date, animated: true)
        
        notificationTwoTimerPicker.addTarget(self, action: #selector(notificationTwoTimerPickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    
    var minutes: Int = 0
    var notificationOneMinutes: Int = 0
    var notificationTwoMinutes: Int = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cancel" {
            } else if identifier == "save" {
                
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
                CoreDataHelper.saveTimer()
            }
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backToMain", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
