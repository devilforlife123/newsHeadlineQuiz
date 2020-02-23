//
//  News.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

struct News:Codable{
    
    var product:String?
    var resultSize:Int?
    var version:Int?
    var items:[NewsArticle]?
    
    enum CodingKeys:String,CodingKey{
        case product
        case resultSize
        case version
        case items
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.product = try container.decodeIfPresent(String.self, forKey: .product)
        self.resultSize = try container.decodeIfPresent(Int.self, forKey: .resultSize)
        self.version = try container.decodeIfPresent(Int.self, forKey: .version)
        self.items = try container.decodeIfPresent([NewsArticle].self, forKey: .items)
        
    }
}
