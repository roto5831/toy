//
//  CollectedCell.swift
//  TIGPlayer
//
//  Created by 小林 宏知 on 2018/04/05.
//  Copyright © 2018年 MMizogaki. All rights reserved.
//

import UIKit

open class CollectedCell: UICollectionViewCell {
    
    @IBOutlet weak var item: UIImageView!{
        didSet{
            item.frame.size = CGSize(width: 50, height: 50)
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
}
