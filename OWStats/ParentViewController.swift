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
    let overwatchAltDarkBlue = UIColor(red: 19/255.0, green: 42/255.0, blue: 77/255.0, alpha:0.85/1.0)
    
    let myGroup = DispatchGroup()
    var check = false
    @IBOutlet weak var playerName: UILabel!

    @IBOutlet weak var OWLogo: UIImageView!
    
    @IBOutlet weak var refresh: UIImageView!
    
    override func viewDidLoad() {
        print ("its here")
        getLatestStats()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settings.style.buttonBarBackgroundColor = overwatchWhite
        settings.style.buttonBarItemBackgroundColor = overwatchWhite
       // settings.style.selectedBarBackgroundColor = overwatchAltDarkBlue
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
            self?.refresh.isUserInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self?.imageTapped))
            self?.refresh.addGestureRecognizer(tapRecognizer)
        }
        myGroup.enter()
        
        
        playerName.text = "dannyo669"
      //  PlayerStatsUtility.getPlayerStats()
       // createUser()
    }
    
    @objc func imageTapped(recognizer: UITapGestureRecognizer){
        getLatestStats()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUser(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
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
        }
        catch{
            print ("Error")
        }
    }
    
    /********************************************************************************
     // This function is an asynchronous call to the api which will get back the latest
     // information about a player in JSON Format.
    ********************************************************************************/
    func getLatestStats(){
        print ("it here tho")
        let urlStr:String = "https://owapi.net/api/v3/u/dannyo669/blob?platform=psn"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        /*Custom UI Indicator*/
        let rectangle = UIView(frame: CGRect(x:0, y:0, width: 200, height:100))
        rectangle.center = view.center
        rectangle.backgroundColor = UIColor(red: 19/255.0, green: 42/255.0, blue: 77/255.0, alpha: 1.0)
        rectangle.alpha = 0.5
        view.addSubview(rectangle)
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            DispatchQueue.main.async {
                
            
                if error == nil{
                    do{
                      
                        print ("INDO")
                        let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                        print (jsonDict)
                        var allData =  (jsonDict["any"]) as! [String:Any]
                        let achievements = allData["achievements"] as! [String:Any]
                        let playerStats = allData["stats"] as! [String:Any]
                        let heroStats = allData["heroes"] as! [String:Any]
                        print (allData)
                        AchievementsUtility.aggregateAchievements(achievements: achievements)
                        PlayerStatsUtility.aggregatePlayerStats(playerStats: playerStats)
                        HeroStatsUtility.aggregateHeroStats(heroStats: heroStats)
                        self.check=true
                        //update view
                        indicator.stopAnimating()
                        rectangle.isHidden = true
                    }
                        
                        
                        
                    catch let error as NSError{
                        print (error)
                        
                    }
                }
            
                else{
                    print ("Error!")
                    DispatchQueue.main.async{
                        indicator.stopAnimating()
                        rectangle.isHidden = true
                    }
                }
            }
                
        })
        print ("at task")
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
    
    /*
     Sets up the other controllers using the library XLPagerTabStrip
     */
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let hero = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeroStats")
        let achievements = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Achievements")
        let live = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Live")
         let player = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerStats")
        return [player, hero, achievements, live]
        
    }

}
