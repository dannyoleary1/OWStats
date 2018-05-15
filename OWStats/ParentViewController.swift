//
//  ParentViewController.swift
//  OWStats
//
//  Created by Danny O'Leary on 14/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import UIKit
import CoreData

//References for how I learned to do this:
//https://medium.com/michaeladeyeri/how-to-implement-android-like-tab-layouts-in-ios-using-swift-3-578516c3aa9
//https://github.com/xmartlabs/XLPagerTabStrip
import XLPagerTabStrip

class ParentViewController: ButtonBarPagerTabStripViewController {
    
    //going to define a colour scheme for a layout.
    let darkBackground = UIColor(red:35/255.0, green:35/255.0, blue:43/255.0, alpha:1.0)
    let darkBackgroundAlt = UIColor(red:41/255.0, green:41/255.0, blue:51/255.0, alpha:1.0)
    let overwatchGray = UIColor(red:180/255.0, green: 186/255.0, blue: 200/255.0, alpha:1.0)
    let overwatchDarkBlue = UIColor(red:19/255.0, green: 42/255.0, blue: 77/255.0, alpha: 0.85)
    let overwatchWhite = UIColor(red:1, green: 1, blue: 1, alpha: 0.60)
    let overwatchBlack = UIColor(red:62/255.0, green: 56/255.0, blue: 58/255.0, alpha:1.00)
    let overwatchLightBlue = UIColor(red:0, green: 195/255.0, blue: 1.0, alpha:1.00)
    let overwatchAltWhite = UIColor(red:246/255.0, green: 246/255.0, blue:246/255.0, alpha:1.00)
    let overwatchAltDarkBlue = UIColor(red: 19/255.0, green: 42/255.0, blue: 77/255.0, alpha:0.2)
    
    
    @IBOutlet weak var playerName: UILabel!
    
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        settings.style.buttonBarBackgroundColor = overwatchWhite
        settings.style.buttonBarItemBackgroundColor = overwatchWhite
        settings.style.selectedBarBackgroundColor = overwatchGray
        settings.style.buttonBarItemFont =  UIFont(name: "futura", size: 14) ?? UIFont.systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
     //   settings.style.buttonBarItemTitleColor = .blue //change
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
    
        
        changeCurrentIndexProgressive = { [weak self] (oldCell:ButtonBarViewCell?, newCell: ButtonBarViewCell?,
                                                       progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(red:62/255.0, green: 56/255.0, blue:58/255.0, alpha:1.00)
            newCell?.label.textColor = UIColor(red:180/255.0, green: 186/255.0, blue: 200/255.0, alpha: 1.00)
            newCell?.contentView.backgroundColor = UIColor(red:19/255.0, green:42/255.0, blue: 77/255.0, alpha: 0.85)
            oldCell?.contentView.backgroundColor = UIColor(red:1, green:1, blue:1,alpha:0.60)
            
        }
        
        getUser()
       // createUser()
        super.viewDidLoad()
     //   getLatestStats()
    }

    func getUser(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
                playerName.text = (data.value(forKey: "username") as! String)
            }
        } catch {
            print ("Failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUser(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("dannyo669", forKey: "username")
        newUser.setValue("psn", forKey: "console")
        
        do{
            try context.save()
        } catch {
            print ("Failed saving")
        }
    }
    
    /********************************************************************************
     // This function is an asynchronous call to the api which will get back the latest
     // information about a player in JSON Format.
    ********************************************************************************/
    func getLatestStats(){
        let urlStr:String = "https://owapi.net/api/v3/u/dannyo669/blob?platform=psn"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if error == nil{
                do{
                    let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                    print (jsonDict)
                }
                catch let error as NSError{
                    print (error)
                }
            }
            else{
                print ("Error!")
            }
            
        })
        task.resume()
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
