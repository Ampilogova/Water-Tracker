//
//  TimeCell.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 8/20/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.

import UIKit

class TimeCell: UICollectionViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var selectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionView.makeRounded()
        selectionView.layer.borderWidth = 1
        selectionView.layer.borderColor = UIColor.aqua.cgColor
    }
    
}
