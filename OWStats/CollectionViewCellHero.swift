//
//  CollectionViewCellHero.swift
//  OWStats
//
//  Created by Danny O'Leary on 17/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCellHero: UICollectionViewCell{
 
    @IBOutlet weak var heroImage: UIImageView!
    
    @IBOutlet weak var heroStatFive: UILabel!
    @IBOutlet weak var heroStatFour: UILabel!
    @IBOutlet weak var heroStatThree: UILabel!
    @IBOutlet weak var heroStatTwo: UILabel!
    @IBOutlet weak var heroStatOne: UILabel!
    
    func displayContent(image: UIImage, statOne: String, statTwo: String, statThree: String, statFour: String, statFive: String){

        heroImage.image = image
        heroStatOne.text = statOne

        heroStatTwo.text = statTwo

        heroStatThree.text = statThree

        heroStatFour.text = statFour

        heroStatFive.text = statFive

    }
}
