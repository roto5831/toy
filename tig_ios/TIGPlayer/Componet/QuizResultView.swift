//
//  QuizResultView.swift
//  TIGPlayer
//
//  Created by 小林 宏知 on 2018/04/02.
//  Copyright © 2018年 MMizogaki. All rights reserved.
//

import Foundation
import UIKit

public protocol QuizResultViewComplement:class{
    func didClose()
}

open class QuizResultView: UIView {
    
    @IBOutlet weak var collectedView: UICollectionView!
    
    @IBOutlet weak var resultDescription: UITextView!
    
    @IBOutlet weak var instructorImage: UIImageView!
    
    weak var comp:QuizResultViewComplement?
    
    var currentContent:CurrentContent?
    
    var items:Items?
    
    var box = [Item]()
    
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
            if let items = self.items{
                self.box = items.populate()
                if self.isAllCorrenct{
                    if let currentContent = self.currentContent{
                        PersistentManager.update(currentContent){
                            currentContent.allCorrectAtLeastOnce = true
                        }
                    }
                }
            }
            self.collectedView.register(UINib(nibName: "CollectedCell", bundle:Bundle(for: type(of: self))), forCellWithReuseIdentifier: "CollectedCell")
            self.collectedView.delegate = self
            self.collectedView.dataSource = self
        }
    }
    
    var isAllCorrenct:Bool{
        //TODO コンテンツリストが持っている正解リストと照らし合せる
        guard self.box.count != 0 else{
            return false
        }
        //コンテンツリストが持っている
        let answers = ["","","",""]
        let pickedItems = self.box.map{$0.itemId}
        return  answers.elementsEqual(pickedItems)
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

extension QuizResultView:UICollectionViewDataSource{
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}

extension QuizResultView:UICollectionViewDelegate{
    
    //     make a cell for each cell index path
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectedCell", for: indexPath as IndexPath) as! CollectedCell
        return cell
    }
}



