//
//  ContentsResultFactory.swift
//  TIGPlayer
//
//  Created by 小林 宏知 on 2018/04/04.
//  Copyright © 2018年 MMizogaki. All rights reserved.
//

import Foundation
import UIKit

public enum contentsType{
    case quiz
    case tig
    case visualDictionary
}

open class ContentsResultFactory{
    
    open func create(type:contentsType,parentView:UIView) -> UIViewController{
        switch type{
        case .quiz:
            let ctr = QuizResultViewController()
            ctr.view.frame = parentView.frame
            if let comp = parentView as? QuizResultViewComplement{
                ctr.comp = comp
            }
            return ctr
        default:
            return UIViewController()
        }
    }
}
