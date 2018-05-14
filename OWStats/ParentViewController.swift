//
//  ParentViewController.swift
//  OWStats
//
//  Created by Danny O'Leary on 14/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import UIKit

//References for how I learned to do this:
//https://medium.com/michaeladeyeri/how-to-implement-android-like-tab-layouts-in-ios-using-swift-3-578516c3aa9
//https://github.com/xmartlabs/XLPagerTabStrip
import XLPagerTabStrip

class ParentViewController: ButtonBarPagerTabStripViewController {
    
    //going to define a colour scheme for a layout.
    let darkBackground = UIColor(red:0.35, green:0.35, blue:0.43, alpha:1.0)
    let darkBackgroundAlt = UIColor(red:0.41, green:0.41, blue:0.51, alpha:1.0)

    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        settings.style.buttonBarBackgroundColor = darkBackgroundAlt
        settings.style.buttonBarItemBackgroundColor = darkBackgroundAlt
        settings.style.selectedBarBackgroundColor = UIColor(red: 33/255.0, green: 174/255.0, blue: 67/255.0, alpha: 1.0)
     //   settings.style.buttonBarItemFont = .systemFont(ofSize: 11)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = darkBackgroundAlt //change
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
    
        
        changeCurrentIndexProgressive = { [weak self] (oldCell:ButtonBarViewCell?, newCell: ButtonBarViewCell?,
                                                       progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 144/255.0, alpha:1.0)
            newCell?.label.textColor = .white
            
        }
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let player = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerStats")
        let hero = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeroStats")
        let achievements = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Achievements")
        let live = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Live")
        return [player, hero, achievements, live]
    }

}
