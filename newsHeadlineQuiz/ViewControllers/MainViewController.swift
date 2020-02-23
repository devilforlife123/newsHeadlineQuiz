//
//  ViewController.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class MainViewController: UIViewController {

    
    //MARK:- IBOUtlets and variables
    @IBOutlet weak var newsImageView:UIImageView!
    @IBOutlet weak var mainImageView:UIImageView!
    @IBOutlet weak var newsTypeLabel:UILabel!
    @IBOutlet weak var questionButton1:UIButton!
    @IBOutlet weak var questionButton2:UIButton!
    @IBOutlet weak var questionButton3:UIButton!
    @IBOutlet weak var questionResponseLabel:UILabel!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    var buttons:[UIButton] = []
    var viewModel:ViewModel = ViewModel()
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [questionButton1,questionButton2,questionButton3,skipButton]
        buttons.forEach{$0.isEnabled = false}
        
        newsTypeLabel.layer.cornerRadius = 5
        buttons.forEach { (button) in
             button.layer.cornerRadius = 5
             button.titleLabel?.lineBreakMode = .byWordWrapping
             button.titleLabel?.textAlignment = .center
             button.titleLabel?.numberOfLines = 0
        }
        self.skipButton.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.configureClosures()
        self.refreshButton.isHidden = true
        
        //Stylize ProgressView
        progressView.layer.borderWidth = 1.0
        progressView.layer.borderColor = UIColor.white.cgColor
        progressView.layer.cornerRadius = 5.0
        progressView.layer.masksToBounds = true
        progressView.backgroundColor = .clear
        progressView.frame = view.bounds
        progressView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.showIndicator(withTitle: "Retrieving Data", and: "Loading Quiz Questions")
        viewModel.loadNewsItems()
       
    }
    
    private func showAlert(title: String = "NewsApp", message: String?) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           let okAction = UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
           }
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
    }
    
    func configureClosures(){
        
        
        viewModel.playAgain = {
            [weak self] in
            GCD.runOnMainThread {
                self?.progressView.progress = 0
            }
        }
        
        viewModel.showAlert = { [weak self]
                     (message) in
           GCD.runOnMainThread {
                self?.hideIndicator()
               self?.showAlert(message: message)
            self?.refreshButton.isHidden = false
           }
        }
        
        viewModel.dataUpdated = {
            [weak self] in
            self?.hideIndicator()
            if let self = self{
                self.refreshButton.isHidden = true
                self.buttons.forEach{$0.isEnabled = true}
                self.mainImageView.subviews.forEach { (view) in
                        view.removeFromSuperview()
                    }
                    if let imageUrl = self.viewModel.newsArray[self.viewModel.currentIndex].imageUrl{
                                 self.newsImageView.kf.setImage(with: URL(string: imageUrl))
                                 self.mainImageView.kf.setImage(with: URL(string: imageUrl))
                        self.mainImageView.addBlur(0.9)
                    }
                    
                    if let newLabel = self.viewModel.newsArray[self.viewModel.currentIndex].section{
                                 self.newsTypeLabel.text = newLabel
                    }
                    
                    if let newHeadlines = self.viewModel.newsArray[self.viewModel.currentIndex].headlines{
                                 for(index,headline) in newHeadlines.enumerated(){
                                    let newsHeadline = headline.replace(target: "â", withString: "'")
                                    self.buttons[index].setTitle(newsHeadline, for: UIControl.State.normal)
                                 }
                    }
                }
            }
    }
    
    
    @IBAction func labelButtonPressed(sender:AnyObject){
        let index = buttons.lastIndex(of: sender as! UIButton)
        if let correctIndex = self.viewModel.newsArray[self.viewModel.currentIndex].correctAnswerIndex{
            self.progressView.progress += CGFloat(1/Double(self.viewModel.newsArray.count))
            if (index == correctIndex){
                buttons.forEach{$0.isEnabled = false}
               UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                   self.questionResponseLabel.center.x =  self.view.bounds.width/2
                   self.view.layoutIfNeeded()
               }) { _ in
                   DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                        if let qvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController {
                                      qvc.newsArticle = self.viewModel.newsArray[self.viewModel.currentIndex]
                                      qvc.delegate = self
                                      qvc.modalPresentationStyle = .overCurrentContext
                                      qvc.modalTransitionStyle = .crossDissolve
                                      qvc.providesPresentationContextTransitionStyle = true
                                      qvc.definesPresentationContext = true
                                      self.present(qvc, animated: true, completion: nil)
                                      }
                   }
               }
            }else{
                viewModel.advanceCounter()
                
            }
        }
    }
    
    @IBAction func skipButtonPressed(){
        viewModel.advanceCounter()
    }
    
    @IBAction func refreshButtonPressed(){
        self.showIndicator(withTitle: "Retrieving Data", and: "Loading Quiz Questions")
        viewModel.loadNewsItems()
    }
    
    
}
extension MainViewController:QuestionViewDelegate{
    func advanceQuestionsToNextCounter() {
        buttons.forEach{$0.isEnabled = true}
        viewModel.advanceCounter()
    }
}

