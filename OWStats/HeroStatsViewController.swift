//
//  HeroStatsViewController.swift
//  OWStats
//
//  Created by Danny O'Leary on 14/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HeroStatsViewController: UIViewController, IndicatorInfoProvider, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSet = HeroStatsUtility.getHeroStats()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSet = HeroStatsUtility.getHeroStats()
        print (dataSet?.count)
        return (dataSet?.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellHero", for: indexPath) as! CollectionViewCellHero
        do{
            print (indexPath.row)
            if (indexPath.row == 0){
                cell.backgroundColor = UIColor(red: 19/255.0, green: 42/255.0, blue: 77/255.0, alpha: 1.0)
            }
            var currentEnt = dataSet![indexPath.row]
        let imageURLString = currentEnt.imageUrl!
            let url = URL(string: imageURLString)
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            let statOne =  "Hours: " + String(format: "%.2f", currentEnt.time_played!)
            let statTwo = "K/D: " + String(format: "%.2f", currentEnt.eliminations_per_life!)
            let statThree = "Kills: " + String(currentEnt.eliminations!)
            let statFour = "Deaths: " + String(currentEnt.deaths!)
            let statFive = "Streak: " + String(currentEnt.kill_streak_best!)
            
            cell.displayContent(image: image!, statOne: statOne, statTwo: statTwo, statThree: statThree, statFour: statFour, statFive: statFive)

        }
        catch{
            print (error)
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        dataSet = HeroStatsUtility.getHeroStats()
        collectionView.reloadData()
        
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
        return IndicatorInfo(title: "HeroStats")
    }

}
