//
//  ViewModel.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

class ViewModel{
    
    var newsArray = [NewsArticle]()
    var currentIndex:Int = 0
    var showAlert:((String)->())?
    var dataUpdated:(()->())?
    var playAgain:(()->())?
    
    let fileName = "NewsData"
    
    func loadNewsItems(){
        if let newsItems = try? DiskCareTaker.retrieve([NewsArticle].self, from: fileName){
            newsArray.append(contentsOf: newsItems)
            self.dataUpdated?()
        }else{
            self.fetchQuizQuestions {
                try! self.save()
                self.dataUpdated?()
            }
        }
    }
    func save()throws{
        try DiskCareTaker.save(newsArray,to:fileName)
    }
    
    func fetchQuizQuestions(completion:@escaping()->()){
        
          self.request { (newsArticle) in
              switch newsArticle{
              case .Success(let news):
                  if let news = news{
                    self.newsArray.append(contentsOf:news.items ?? [])
                  }
                  completion()
              case .Failure(let message):
                  self.showAlert?(message)
              case .Error(let error):
                  self.showAlert?(error)
              }
          }
         
      }
    
    func request(completion:@escaping (Result<News?>)->()){
     GCD.runAsync {
         NetworkManager.shared.getNews { (result) in
                       switch result{
                       case .Success(let responseData):
                           if let model = self.processResponse(responseData){
                               return completion(.Success(model))
                               
                           }else {
                               return completion(.Failure(NetworkManager.errorMessage))
                           }
                       case .Failure(let message):
                           return completion(.Failure(message))
                       case .Error(let error):
                           return completion(.Failure(error))
                       }
                   }
         }
    }
    
    func processResponse(_ data:Data)->News?{
        
      do {
          let decoder = JSONDecoder()
          let newsData = try decoder.decode(News.self, from: data)
          return newsData
          
      } catch let err {
          print("Err", err)
          return nil
      }

    }
    
    func advanceCounter(){
        
        if(currentIndex < self.newsArray.count){
            currentIndex += 1;
            self.dataUpdated?()
        }else{
            currentIndex = 0
            self.playAgain?()
            self.dataUpdated?()
        }
        
    }
}
