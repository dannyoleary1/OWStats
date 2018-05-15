//
//  AchievementsUtility.swift
//  OWStats
//
//  Created by Danny O'Leary on 15/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AchievementsUtility{
    
    
    
    /*
     A simple get request to CoreData. This may be used later in the project but right now it simply prints out.
    */
    class func getAchievements(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Achievements")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data)
            }
        } catch {
            print ("Failed")
        }    }
    
    /*
     reference: https://stackoverflow.com/questions/26345189/how-do-you-update-a-coredata-entry-that-has-already-been-saved-in-swift
     this function will check if an existing coredata entry exists for achievements and if it does, that will be updated. However, if it
     does not, it will create a new entry.
    */
    class func aggregateAchievements(achievements: [String: Any]){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Achievements")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request) as? [NSManagedObject]
            if result?.count == 0{
                let entity = NSEntityDescription.entity(forEntityName: "Achievements", in: context)
                let newAchievement = NSManagedObject(entity: entity!, insertInto: context)
                for (_, value) in achievements{
                    let value = value as! [String:Any]
                    for (key, entry) in value{
                        var completed = false
                        if entry as! Int == 1{
                            completed = true
                        }
                        newAchievement.setValue(completed, forKey: key)
                    }
                }
                do{
                    try context.save()
                } catch {
                    print ("Failed Saving")
                }
            }
            else{
                for (_, value) in achievements{
                    let value = value as! [String:Any]
                    for (key, entry) in value{
                        var completed = false
                        if entry as! Int == 1{
                            completed = true
                        }
                        result![0].setValue(completed, forKey: key)
                    }
                }
                do{
                    try context.save()
                } catch {
                    print ("Failed Saving")
                }
            }
        }
        catch{
            print ("errorrs!")
        }
    }
    
}
