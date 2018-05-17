//
//  HeroStatsUtility.swift
//  OWStats
//
//  Created by Danny O'Leary on 17/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct Hero {
    var heroName: String!
    var deaths: Int!
    var eliminations: Int!
    var eliminations_per_life: Float!
    var imageUrl: String!
    var kill_streak_best: Int!
    var time_played: Float!
}

class HeroStatsUtility{
    
    
    class func getHeroStats() -> [Hero]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HeroStats")
        request.returnsObjectsAsFaults = false
        var heroArray = [Hero]()
        do{
            let result = try context.fetch(request)
            print (result.count)
            for data in result as! [NSManagedObject]{
                heroArray.append(Hero(heroName: data.value(forKey: "heroName") as! String, deaths: data.value(forKey: "deaths") as! Int, eliminations: data.value(forKey: "eliminations") as! Int, eliminations_per_life: data.value(forKey: "eliminations_per_life") as! Float, imageUrl: data.value(forKey: "imageUrl") as! String, kill_streak_best: data.value(forKey: "kill_streak_best") as! Int, time_played: data.value(forKey: "time_played") as! Float))
                print (data.value(forKey: "eliminations") as! Float)
            }
            return heroArray
        } catch {
            print ("Failed")
        }
        return nil
    }
    
    class func aggregateHeroStats(heroStats: [String:Any]){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HeroStats")
        request.returnsObjectsAsFaults = false
        

        var generalStats = heroStats["stats"] as! [String:Any]
        var compGenStats = generalStats["quickplay"] as! [String:Any]
        let wantedInfo = ["eliminations", "deaths", "eliminations_per_life", "time_played", "kill_streak_best"]
        var currentNo = 0
        for (key, value) in compGenStats{
            //quickplay
            do {
                
               let result = try context.fetch(request) as? [NSManagedObject]
                if result?.count != 25{
                    
                    let entity = NSEntityDescription.entity(forEntityName: "HeroStats", in: context)
                    let newHero = NSManagedObject(entity: entity!, insertInto: context)
                    print (key)
                    newHero.setValue(key, forKey: "heroName")
                    
                    let imageUrl = getImage(hero: key)
                    newHero.setValue(imageUrl, forKey: "imageUrl")
                    var genStats = compGenStats[key] as! [String:Any]
                    var newStats = genStats["general_stats"] as! [String:Any]
                    for (currentKey, currentValue) in newStats{
                        if (wantedInfo.contains(currentKey)){
                            newHero.setValue(currentValue, forKey: currentKey)
                        }
                    }
                    do{
                        try context.save()
                        
                    } catch{
                        print ("Failed Saving")
                    }
                }
                else{


                        result![currentNo].setValue(key, forKey: "heroName")
                        let imageUrl = getImage(hero: key)
                        result![currentNo].setValue(imageUrl, forKey: "imageUrl")
                        var genStats = compGenStats[key] as! [String:Any]
                        var newStats = genStats["general_stats"] as! [String:Any]
                        for (currentKey, currentValue) in newStats{
                            if (wantedInfo.contains(currentKey)){
                            result![currentNo].setValue(currentValue, forKey: currentKey)
                            }
                        }
                        do{
                            try context.save()
                        } catch{
                            print ("Failed Saving")
                        }
                    currentNo+=1
                }
            }
            catch{
                print ("Failed")
            }
        }
       
    }
    
    class func getImage(hero: String) -> String{
        let url = "https://www.overbuff.com/assets/images/heroes/"
        switch hero{
        case "hanzo":
            return url+"hanzo.png?v=bfbf2fb"
        case "dva":
            return url+"dva.png?v=bfbf2fb"
        case "tracer":
            return url+"tracer.png?v=bfbf2fb"
        case "junkrat":
            return url+"junkrat.png?v=bfbf2fb"
        case "torbjorn":
            return url+"torbjorn.png?v=bfbf2fb"
        case "reaper":
            return url+"reaper.png?v=bfbf2fb"
        case "mercy":
            return url+"mercy.png?v=bfbf2fb"
        case "lucio":
            return url+"lucio.png?v=bfbf2fb"
        case "winston":
            return url+"winston.psg?v=bfbf2fb"
        case "soldier76":
            return url+"soldier76.png?v=bfbf2fb"
        case "symmetra":
            return url+"symmetra.png?v=bfbf2fb"
        case "zenyatta":
            return url+"zenyatta.png?v=bfbf2fb"
        case "ana":
            return url+"ana.png?v=bfbf2fb"
        case "mccree":
            return url+"mccree.png?v=bfbf2fb"
        case "zarya":
            return url+"zarya.png?v=bfbf2fb"
        case "genji":
            return url+"genji.png?v=bfbf2fb"
        case "widowmaker":
            return url+"windowmaker.png?v=bfbf2fb"
        case "roadhog":
            return url+"roadhog.png?v=bfbf2fb"
        case "orisa":
            return url+"orisa.png?v=bfbf2fb"
        case "sombra":
            return url+"sombra.png?v=bfbf2fb"
        case "pharah":
            return url+"pharah.png?v=bfbf2fb"
        case "reinhardt":
            return url+"reinhardt.png?v=bfbf2fb"
        case "moira":
            return url+"moira.png?v=bfbf2fb"
        case "doomfist":
            return url+"doomfist.png?v=bfbf2fb"
        case "bastion":
            return url+"bastion.png?v=bfbf2fb"
        default:
            return url+"hanzo.png?v=bfbf2fb"
        }
    }
}
