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
    
    open func create(type:contentsType,parentView:UIView) -> UIView{
        switch type{
        case .quiz:
            if let quizResultView = Bundle(for: QuizResultView.self).loadNibNamed(String(describing: QuizResultView.self), owner: parentView, options: nil)?.last as? QuizResultView{
                if let comp = parentView as? QuizResultViewComplement{
                    quizResultView.comp = comp
                }
                return quizResultView
            }else{
                return UIView()
            }
        default:
            return UIView()
        }
    }
}
