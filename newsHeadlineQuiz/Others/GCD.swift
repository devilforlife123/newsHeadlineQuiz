//
//  GCD.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation

class GCD{
    
    static func runAsync(closure:@escaping()->()){
        DispatchQueue.global(qos: .userInitiated).async {
            closure()
        }
    }
    
    static func runOnMainThread(closure:@escaping()->()){
        DispatchQueue.main.async {
            closure()
        }
    }
}
