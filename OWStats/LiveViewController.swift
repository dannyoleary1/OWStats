//
//  LiveViewController.swift
//  OWStats
//
//  Created by Danny O'Leary on 14/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import WebKit

class LiveViewController: UIViewController, IndicatorInfoProvider {

    
    @IBOutlet weak var webPlayer: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let interactiveEmbedCode = """
//        <div id="player"></div>
//        <script type="text/javascript">
//        var options = {
//        width: "1280",
//        height: "720",
//        channel: "overwatch",
//        playsinline: "true",
//        };
//        var player = new Twitch.Player("player", options);
//        player.setVolume(0.5);
//        </script>
//        """
        let interactiveEmbedCode = """
        <div id="player"></div>
        <script type="text/javascript">
        var options = {
        width: "1280",
        height: "720",
        channel: "dallas",
        video: "v106400740",
        "playsinline": "true"
        };
        var player = new Twitch.Player("player", options);
        player.setVolume(0.5);
        </script>
        """
        print("itloads?")
        
        webPlayer.loadHTMLString(interactiveEmbedCode, baseURL: nil)
        print (webPlayer)
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
        return IndicatorInfo(title: "Live")
    }

}
