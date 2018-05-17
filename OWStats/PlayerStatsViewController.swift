//
//  PlayerStatsViewController.swift
//  OWStats
//
//  Created by Danny O'Leary on 14/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Charts
import CoreData


class PlayerStatsViewController: UIViewController, IndicatorInfoProvider {
    
    //reference: https://github.com/annalizhaz/ChartsForSwiftBasic
    @IBOutlet weak var skillChart: PieChartView!
    @IBOutlet weak var levelChart: PieChartView!
    
    @IBOutlet weak var gamesValue: UILabel!
    @IBOutlet weak var winsValue: UILabel!
    @IBOutlet weak var lossesValue: UILabel!
    @IBOutlet weak var killsValue: UILabel!
    @IBOutlet weak var streakValue: UILabel!
    @IBOutlet weak var winRateValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skillChart.backgroundColor = UIColor(red:19/255.0, green:42/255.0, blue:77/255.0, alpha:1.0)
        levelChart.backgroundColor = UIColor(red:19/255.0, green:42/255.0, blue:77/255.0, alpha:1.0)
        
        
       
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool){
        let data = PlayerStatsUtility.getPlayerStats()
        if (data != nil){
            skillChartUpdate(data: data!)
            levelChartUpdate(data: data!)
            useData(data: data!) 
        }
        
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
        //storyboardID goes here.
        return IndicatorInfo(title: "PlayerStats")
    }
    
    func useData(data: NSManagedObject){
        gamesValue.text = String(data.value(forKey: "games") as! Float)
        winsValue.text = String(data.value(forKey: "wins") as! Float)
        lossesValue.text = String(data.value(forKey: "losses") as! Float)
        killsValue.text = String(data.value(forKey: "eliminations_most_in_game") as! Float)
        streakValue.text = String(data.value(forKey: "kill_streak_best") as! Float)
        winRateValue.text = String(data.value(forKey: "win_rate") as! Float)+"%"
    }
    
    func skillChartUpdate(data: NSManagedObject){
        var entryValue = (data.value(forKey: "comprank") as! Float)
        var remainingValue = entryValue.remainder(dividingBy: 100)
        let entry1 = PieChartDataEntry(value: Double(100 - remainingValue))
        let entry2 = PieChartDataEntry(value: Double(remainingValue))
        let dataSet = PieChartDataSet(values: [entry1, entry2], label: "Skill Rating")
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        var colors: [UIColor] = []
        colors.append(UIColor(red:0, green: 195/255.0, blue: 1.0, alpha:1.00))
        colors.append(.gray)
        dataSet.colors = colors
        let data = PieChartData(dataSet: dataSet)
        data.setValueTextColor(.white)
        skillChart.data = data
        skillChart.drawEntryLabelsEnabled = false
        skillChart.legend.enabled = false
        skillChart.chartDescription?.text = ""
//        skillChart.holeColor = UIColor(red:19/255.0, green:42/255.0, blue:77/255.0, alpha:1.0)
//        skillChart.holeColor = .clear
        skillChart.isOpaque = true
        skillChart.centerText = String(entryValue)
        skillChart.entryLabelColor = .white
        skillChart.noDataTextColor = .white
        skillChart.notifyDataSetChanged()
    }
    
    func levelChartUpdate(data: NSManagedObject){
        var entryValue = (data.value(forKey: "level") as! Float)
        var remainingValue = entryValue.remainder(dividingBy: 100)
        print (remainingValue)
        let entry1 = PieChartDataEntry(value: Double(entryValue))
        let entry2 = PieChartDataEntry(value: Double(100 - remainingValue))
        let dataSet = PieChartDataSet(values: [entry1, entry2], label: "Skill Rating")
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        var colors: [UIColor] = []
        colors.append(UIColor(red:0, green: 195/255.0, blue: 1.0, alpha:1.00))
        colors.append(.gray)
        dataSet.colors = colors
        let data = PieChartData(dataSet: dataSet)
        data.setValueTextColor(.white)
        levelChart.data = data
        levelChart.drawEntryLabelsEnabled = false
        levelChart.legend.enabled = false
        levelChart.chartDescription?.text = ""
        //        skillChart.holeColor = UIColor(red:19/255.0, green:42/255.0, blue:77/255.0, alpha:1.0)
        //        skillChart.holeColor = .clear
        levelChart.isOpaque = true
        levelChart.centerText = String(entryValue)
        levelChart.entryLabelColor = .white
        levelChart.noDataTextColor = .white
        levelChart.notifyDataSetChanged()
    }
}
