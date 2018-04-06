//
//  QuizResultViewController.swift
//  TIGPlayer
//
//  Created by 小林 宏知 on 2018/04/02.
//  Copyright © 2018年 MMizogaki. All rights reserved.
//

import UIKit

class QuizResultViewController: UIViewController {

    var quizResultView:QuizResultView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let factory = ContentsResultFactory()
        self.quizResultView = factory.create(type:contentsType.quiz,parentView:self.view) as! QuizResultView
        self.quizResultView.frame = self.view.frame
        self.view.addSubview(self.quizResultView)
        self.quizResultView.collectedView.register(UINib(nibName: "CollectedCell", bundle:Bundle(for: type(of: self))), forCellWithReuseIdentifier: "CollectedCell")
        self.quizResultView.collectedView.delegate = self
        self.quizResultView.collectedView.dataSource = self
    }
}

extension QuizResultViewController:UICollectionViewDataSource{

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}

extension QuizResultViewController:UICollectionViewDelegate{

    //     make a cell for each cell index path
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectedCell", for: indexPath as IndexPath) as! CollectedCell
        return cell
    }
}

