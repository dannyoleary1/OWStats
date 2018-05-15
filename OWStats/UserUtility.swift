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
                return (data.value(forKey: "username") as! String)
               // playerName.text = (data.value(forKey: "username") as! String)
            }
        } catch {
            return ("Not found")
        }
        return ("Not found")
    }
}
