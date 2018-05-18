//
//  UserUtility.swift
//  OWStats
//
//  Created by Danny O'Leary on 15/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserUtility{
    
    class func getUser() -> String{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if result.count == 0{
                    let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
                    let newUser = NSManagedObject(entity: entity!, insertInto: context)
                    do{
                        let result = try context.fetch(request) as? [NSManagedObject]
                        print(result?.count)
                        if result?.count != 1{
                            newUser.setValue("dannyo669", forKey: "username")
                            newUser.setValue("psn", forKey: "console")
                            do{
                                try context.save()
                            } catch {
                                print ("Failed saving")
                            }
                        }
                        return  (data.value(forKey: "username") as! String)
                    
                    }
                    catch{
                        print ("Error")
                    }
                }
                if (data.value(forKey:"username") as! String == nil){
                    (result[0] as AnyObject).setValue("dannyo669", forKey: "username")
                    (result[0] as AnyObject).setValue("psn", forKey: "console")
                }
                return (data.value(forKey: "username") as! String)
               // playerName.text = (data.value(forKey: "username") as! String)
            }
        } catch {
            return ("Not found")
        }
        return ("Not found")
    }
}
