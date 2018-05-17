//
//  PlayerStatsUtility.swift
//  OWStats
//
//  Created by Danny O'Leary on 15/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PlayerStatsUtility{
    
    /*
     A simple get request to CoreData. This may be used later.
     */
    class func getPlayerStats() -> NSManagedObject?{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerStatsComp")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print (result)
            for data in result as! [NSManagedObject] {
                return data
            }
        } catch {
            print ("Failed")
            
        }
        return nil
    }
    /*
     Reference: aggregateAchievements function in Utility class.
     Function will aggregate latest player stats to existing entry
     If no entry exists, it will create a new entry.
    */
    class func aggregatePlayerStats(playerStats: [String:Any]){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerStatsComp")
        request.returnsObjectsAsFaults = false
        
        //General setup
        var competitiveStats = playerStats["competitive"] as! [String:Any]
        let game_stats = competitiveStats["game_stats"] as! [String:Any]
        let overall_stats = competitiveStats["overall_stats"] as! [String:Any]
        //I don't want to collect all the stats. So it will be compared vs 2 lists.
        let game_stats_wanted = ["deaths", "eliminations", "eliminations_most_in_game", "kill_streak_best", "kpd"]
        let overall_stats_wanted = ["avatar", "comprank", "games", "level", "losses", "prestige", "rank_image", "tier", "tier_image", "win_rate", "wins"]
        
        do{
            let result = try context.fetch(request) as? [NSManagedObject]
            if result?.count == 0 {
                let entity = NSEntityDescription.entity(forEntityName: "PlayerStatsComp", in: context)
                let newStats = NSManagedObject(entity: entity!, insertInto: context)
                for (key, value) in game_stats{
                    if (game_stats_wanted.contains(key)){
                        newStats.setValue(value, forKey: key)
                    }
                }
                for (key,value) in overall_stats{
                    if (overall_stats_wanted.contains(key)){
                        newStats.setValue(value, forKey: key)
                    }
                }
                do{
                    try context.save()
                } catch {
                    print ("Failed Saving")
                }
            }
            else{
                for (key, value) in game_stats{
                    if (game_stats_wanted.contains(key)){
                        result![0].setValue(value, forKey: key)
                    }
                }
                for (key, value) in overall_stats{
                    if (overall_stats_wanted.contains(key)){
                        result![0].setValue(value, forKey: key)
                    }
                }
                do{
                    try context.save()
                } catch {
                    print ("Failed Saving")
                }
            }
        } catch{
            print ("Errors")
        }
    }
    
    
}
