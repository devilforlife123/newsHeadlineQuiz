//
//  NewsArticle.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation

struct NewsArticle:Codable{
    var correctAnswerIndex:Int?
    var imageUrl:String?
    var articleDetail:String?
    var articleUrl:String?
    var section:String?
    var headlines:[String]?
    
    enum CodingKeys:String,CodingKey{
       case correctAnswerIndex
       case imageUrl
       case articleDetail = "standFirst"
       case articleUrl = "storyUrl"
       case section
       case headlines
    }
    
    init(from decoder: Decoder) throws {
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
          self.correctAnswerIndex  = try container.decodeIfPresent(Int.self, forKey: .correctAnswerIndex)
           self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
           self.articleDetail = try container.decodeIfPresent(String.self, forKey: .articleDetail)
           self.articleUrl = try container.decodeIfPresent(String.self, forKey: .articleUrl)
           self.section = try container.decodeIfPresent(String.self, forKey: .section)
           self.headlines = try container.decodeIfPresent([String].self, forKey: .headlines)
           
       }
    
}
