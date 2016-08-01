//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
        
    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
        
        let secret = Secrets()
        
        let urlString = "\(secret.APIURL)/repositories?client_id=\(secret.ClientID)&client_secret=\(secret.ClientSecret)"
        
        let url = NSURL(string: urlString)
        
        print(url)
        
        let session = NSURLSession.sharedSession()
        
        guard let potentialURL = url else {assertionFailure("Invalid URL"); return}
        
        let dataTask = session.dataTaskWithURL(potentialURL) { (data, response, error) in
            
            print(data)
            print(response)
            print(error)
            
            //do
            guard let returnData = data else { assertionFailure("Unable to get data \(error?.localizedDescription)"); return }
        
            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(returnData, options: []) as! NSArray{
                
             //catch
                print(responseArray)
                
                    completion(responseArray)
            
//                var responseArray = []
//                do {
//                    if let returnData = data {
//                        
//                        responseArray = try! NSJSONSerialization.JSONObjectWithData(returnData, options: []) as! NSArray
//                        print(responseArray)
//                        completion(responseArray)
//                    }
//                }catch {
//                    
//                    print(error)
//                    completion(responseArray)
            }
        }
        
        dataTask.resume()
    }
}

