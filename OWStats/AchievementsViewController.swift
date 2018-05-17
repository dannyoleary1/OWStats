//
//  AchievementsViewController.swift
//  OWStats
//
//  Created by Danny O'Leary on 14/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import UIKit
import XLPagerTabStrip


/*
 Reference: https://medium.com/yay-its-erica/creating-a-collection-view-swift-3-77da289bb7c
 */
class AchievementsViewController: UIViewController, IndicatorInfoProvider, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var achievementsList = Achievement.setupAchievements()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievementsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        do{
        let currentEnt = achievementsList[indexPath.row]
        
        let imageURLString = currentEnt.imageUrl
            let url = URL(string: imageURLString!)
        let data = try Data(contentsOf: url!)
       
        let image = UIImage(data: data)
         
       
            cell.displayContent(image: image!, title: currentEnt.name!, description: currentEnt.descrption!)
        }
        catch{
            //placeholder
            print (error)
        }
        return cell
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        //storyboard id goes here.
        return IndicatorInfo(title: "Achievements")
    }
}
