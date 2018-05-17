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
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellHero", for: indexPath) as! CollectionViewCellHero
        do{
            print (indexPath.row)
            if (indexPath.row == 0){
                cell.backgroundColor = UIColor(red: 19/255.0, green: 42/255.0, blue: 77/255.0, alpha: 1.0)
            }
        let imageURLString = "https://www.overbuff.com/assets/images/heroes/genji.png?v=bfbf2fb"
            let url = URL(string: imageURLString)
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            cell.displayContent(image: image!, statOne: "test", statTwo: "test", statThree: "test", statFour: "test", statFive: "test")

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
