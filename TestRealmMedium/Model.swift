//
//  Model.swift
//  TestRealmMedium
//
//  Created by Elle Ti on 6/8/18.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import Foundation
import RealmSwift

public struct CoinTokens: Codable {
    public var full_name: String?
    public var symbol: String?
    public var image_url: String?
    public var updated_at: Int?
}

//public class CoinManager {
//    public var tokenList = [CoinTokens]()
//    
//    public init() {
//        tokenList.append(CoinTokens(full_name: "Bitcoin", symbol: "BTC", image_url: "testurl.com", updated_at: 1234567890))
//        tokenList.append(CoinTokens(full_name: "Ethereum", symbol: "ETH", image_url: "testurl2.com", updated_at: 1654824551))
//        tokenList.append(CoinTokens(full_name: "Ark", symbol: "ARK", image_url: "testurl3.com", updated_at: 1543214998))
//    }
//}

public class APIManager {
    
    let serverAddress = "http://localhost:3000/v1/coins_infos"
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJkZXZpY2VfaWQiOiJkZXZpY2UxIn0.hJUtGtgmKLdwRHEkjdhmHkrhQWW-Hnluxe6vhQmgALY"
    var tokenInfo = [CoinTokens]()
    
    public func getTokenInfo(completion: @escaping ([CoinTokens]?, Error?) -> ()) {
        let addressURL = URL(string: "\(serverAddress)")
        
        var request = URLRequest(url: addressURL!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("Server Address \(serverAddress)")
        print("Request: \(request)")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            guard let data = data else { return }
                do {
                    self.tokenInfo = try JSONDecoder().decode([CoinTokens].self, from: data)
                    completion(self.tokenInfo, nil)
                }
                catch let jsonError {
                    completion(nil, jsonError)
                }
            }.resume()
        }
// **********************************************************************************************************************
//            else if let data = data {
//                do {
//                    let infoDictionary = try JSONDecoder().decode([String: TokenEndpointInfo].self, from: data)
//                    print("Info Dictionary \(infoDictionary)")
//                    if let coinTokenInfo = infoDictionary["api_last_updated"] {
//                        completion(coinTokenInfo, nil)
//                        print("Items: \(coinTokenInfo)")
//                    }
//                    else {
//                        completion(nil, nil)
//                    }
//                }
//                catch let jsonError {
//                    completion(nil, jsonError)
//                }
//            }
            
// **********************************************************************************************************************
//            guard (error == nil) else {
//                print("An error: \n\(String(describing: error))\n")
//                return
//            }
//            // Result
//            let parseResult: [String: AnyObject]!
//            do {
//                parseResult = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
//                print("Parse result: \(parseResult)")
//            }
//            catch {
//                print("Could not parse data as JSON \(error)")
//            }
// **********************************************************************************************************************
//            else if let data = data {
//                do {
//                    let tokenInfo = try JSONDecoder().decode([TokenEndpointInfo].self, from: data)
//                    completion(tokenInfo, nil)
//                }
//                catch let jsonError {
//                    completion(nil, jsonError)
//                }
//            }
//        }.resume()
}
