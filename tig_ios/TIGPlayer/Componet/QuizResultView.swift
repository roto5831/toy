//
//  QuizResultView.swift
//  TIGPlayer
//
//  Created by 小林 宏知 on 2018/04/02.
//  Copyright © 2018年 MMizogaki. All rights reserved.
//

import Foundation

public protocol QuizResultViewComplement:class{
    func didClose()
}

open class QuizResultView: UIView {
    
    var currentContent:CurrentContent?
    var items:Items?{
        didSet{
            if let items = items{
                self.box = items.populate()
                if self.isAllCorrenct{
                    if let currentContent = self.currentContent{
                        currentContent.allCorrectAtLeastOnce = true
                    }
                }
            }
        }
    }
    
    var box = [Item]()
    
    var comp:QuizResultViewComplement?
    
    override open func awakeFromNib() {
        self.build()
    }
    
    func build(){
        self.currentContent =
            PersistentManager.getByPrimaryKey(
                CurrentContent.self,
                primaryKey:PersistentManager.PersistentCosnt.PrimaryKey.CurrentContent.rawValue
            )
        if let currentContent = self.currentContent{
            self.items = PersistentManager.getByPrimaryKey(Items.self, primaryKey: currentContent.contentsId)
        }
    }
    
    var isAllCorrenct:Bool{
        guard self.box.count != 0 else{
            return false
        }
        var allCorrect = true
        self.box.forEach{ item in
            if !item.correct{
               allCorrect = false
            }
        }
        return allCorrect
    }
    
    @IBAction func test(_ sender: Any) {
        if let currentContent = self.currentContent{
            //アイテム全消し
            if let items = self.items{
                for item in (items.list) {
                    PersistentManager.delete(ItemModel.self, primaryKey: "\(currentContent.contentsId)\(item.itemId)")
                }
                PersistentManager.delete(Items.self, primaryKey: currentContent.contentsId)
            }
            self.comp?.didClose()
        }
        self.removeFromSuperview()
    }
}
