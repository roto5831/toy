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
    case tig
    case quiz
    case visualDictionary
}
///現在再生されているコンテンツに基づいてコントローラーを生成
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
