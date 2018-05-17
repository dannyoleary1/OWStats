//
//  Achievement.swift
//  OWStats
//
//  Created by Danny O'Leary on 16/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//


struct AchievementObject{
    var name: String?
    var completed: Bool?
    var imageUrl: String?
    var descrption: String?
}

import Foundation
import UIKit
class Achievement{
    class func setupAchievements() -> [AchievementObject] {
        var achievementObject = [AchievementObject]()
        achievementObject.append(AchievementObject(name: "The Friend Zone", completed: true, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/2Mc559a3.png", descrption: "Play with a friend."))
        achievementObject.append(AchievementObject(name: "Centenary", completed: true, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/3M0491a4.png", descrption: "Win 100 games."))
        achievementObject.append(AchievementObject(name: "Level 10", completed: true, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/3M0491a4.png", descrption: "Reach Level 10."))
        achievementObject.append(AchievementObject(name: "Level 25", completed: true, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/5M7ba607.png", descrption: "Reach Level 25."))
        achievementObject.append(AchievementObject(name: "Level 50", completed: false, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/6Ma390ce.png", descrption: "Reach Level 50."))
        achievementObject.append(AchievementObject(name: "The Path is Closed", completed: true, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/7M7020b1.png", descrption: "Destroy 3 Symmetra's Teleporters"))
        achievementObject.append(AchievementObject(name: "Survival Expert", completed: true, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/8Mf6767f.png", descrption: "Heal 900 health using medpacks."))
        achievementObject.append(AchievementObject(name: "Decorated", completed: true, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/9M872be8.png", descrption: "Earn 50 Medals."))
        achievementObject.append(AchievementObject(name: "Blackjack", completed: true, imageUrl: "https://i.psnprofiles.com/games/934632/trophies/10M0795ba.png", descrption: "Earn 21 postgame cards."))
        return achievementObject
    }
}
