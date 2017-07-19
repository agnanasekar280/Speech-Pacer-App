//
//  SetNewTimerViewController.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/11/17.
//  Copyright © 2017 The Girl Code. All rights reserved.

import UIKit

class SetNewTimerViewController: UIViewController{
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var timerTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("Cancel button tapped")
            } else if identifier == "save" {
                print("Save button tapped")
                
                let timer = setTime()
                timer.title = titleTextField.text ?? ""
                timer.time = Date()
                
                let listTimersTableViewController = segue.destination as! ChooseTimerViewController
                listTimersTableViewController.timers.append(timer)
            }
        }
    }

    
    @IBAction func save(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backToMain", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timerPicker = UIDatePicker()
        timerPicker.datePickerMode = UIDatePickerMode.countDownTimer
        timerPicker.addTarget(self, action: #selector(SetNewTimerViewController.timerPickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        timerTextField.inputView = timerPicker
        
    }
    
    
    func timerPickerValueChanged(sender: UIDatePicker){
        
        let timerFormatter = DateFormatter()
        timerFormatter.timeStyle = DateFormatter.Style.medium
        timerTextField.text = timerFormatter.string(from: sender.date)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
