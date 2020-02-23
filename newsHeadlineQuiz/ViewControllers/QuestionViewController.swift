//
//  QuestionViewController.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

protocol QuestionViewDelegate:AnyObject{
    func advanceQuestionsToNextCounter()
}

class QuestionViewController:UIViewController{
    @IBOutlet weak var leaderBoardButton: UIButton!
    @IBOutlet weak var roundedLabel1: RoundedLabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var readStoryButton: UIButton!
    @IBOutlet weak var insideImageView: UIImageView!
    
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyDetailTextview: UITextView!
    weak var delegate:QuestionViewDelegate!
    var newsArticle:NewsArticle?
    
    override func viewDidLoad() {
        leaderBoardButton.titleLabel?.adjustsFontSizeToFitWidth = true
        updateUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        roundedLabel1.clear()
    }
    
    
    func updateUI(){
        self.leaderBoardButton.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        if let newArticle = newsArticle{
            if let imageUrl = newsArticle?.imageUrl{
                self.insideImageView.kf.setImage(with: URL(string:imageUrl))
                self.mainImageView.kf.setImage(with: URL(string:imageUrl))
                self.mainImageView.addBlur(0.9)
            }
            
            if let storyTitle = newArticle.headlines?[newArticle.correctAnswerIndex!]{
                self.storyTitleLabel
                    .text = storyTitle.replacingOccurrences(of: "â", with: "'")
                self.storyDetailTextview.text = newArticle.articleDetail?.replacingOccurrences(of: "â", with: "'")
            }
        }
    }
    
    @IBAction func readArticle(_ sender: Any) {
        if let articleURL = newsArticle?.articleUrl{
            if let url = URL(string:articleURL){
                 UIApplication.shared.open(url)
            }
        }
    }
    @IBAction func readNextStory(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate.advanceQuestionsToNextCounter()
    }
}
