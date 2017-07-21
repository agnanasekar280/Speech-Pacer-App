//
//  CoreDataHelper.swift
//  Speech Pacer
//
//  Created by Aditi Gnanasekar on 7/19/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    static func newTimer() -> Timesaver {
        let timer = NSEntityDescription.insertNewObject(forEntityName: "Timesaver", into: managedContext) as! Timesaver
        return timer
    }
    
    static func saveTimer() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(timer: Timesaver) {
        managedContext.delete(timer)
        saveTimer()
    }
    
    static func retrieveTimers() -> [Timesaver] {
        let fetchRequest = NSFetchRequest<Timesaver>(entityName: "Timesaver")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    
}

