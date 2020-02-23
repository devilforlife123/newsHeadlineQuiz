//
//  NetworkManager.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation
import Alamofire

struct API{
    static let urlAddress = "https://firebasestorage.googleapis.com/v0/b/nca-dna-apps-dev.appspot.com/o/game.json?alt=media&token=e36c1a14-25d9-4467-8383-a53f57ba6bfe"
}

class NetworkManager:NSObject{
    
    static let shared = NetworkManager()
    static let errorMessage = "Something went wrong, Please try again later"
    static let noInternetConnection = "Please check your Internet connection and try again."
    
    
    func getNews(completion: @escaping (Result<Data>)->()){
        
        guard (Reachability.currentReachabilityStatus != .notReachable)else{
                  return
                      completion(.Failure(NetworkManager.noInternetConnection))
        }
        
        AF.request(API.urlAddress, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
            debugPrint(response)

            guard let data = response.data else {
                return completion(.Failure(response.error?.localizedDescription ?? NetworkManager.errorMessage))
            }
            return completion(.Success(data))
            
            
            }
        }
    
}
