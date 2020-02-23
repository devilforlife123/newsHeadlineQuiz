//
//  String+Extension.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
  func replace(target: String, withString: String) -> String{
    return self.replacingOccurrences(of: target, with: withString)
   }
}

