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
    weak var comp:QuizResultViewComplement?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if let quizResultView = Bundle(for: QuizResultView.self).loadNibNamed(String(describing: QuizResultView.self), owner: self, options: nil)?.last as? QuizResultView{
            quizResultView.comp = self
            self.quizResultView = quizResultView
            quizResultView.frame = self.view.frame
            self.view.addSubview(quizResultView)
        }
    }
}

extension QuizResultViewController:QuizResultViewComplement{
    func didClose() {
        self.dismiss(animated: false, completion: nil)
        self.comp?.didClose()
    }
}
