//
//  CollectionViewCell.swift
//  OWStats
//
//  Created by Danny O'Leary on 15/05/2018.
//  Copyright © 2018 Danny O'Leary. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var achievementImage: UIImageView!
    @IBOutlet weak var achievementTitle: UILabel!
    
    @IBOutlet weak var achievementDescription: UILabel!
    func displayContent(image: UIImage, title: String, description: String){
        achievementImage.image = image
        achievementTitle.text = title
        achievementDescription.text = description
    }
}
