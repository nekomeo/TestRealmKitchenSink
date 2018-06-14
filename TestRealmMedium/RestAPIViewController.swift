//
//  RestAPIViewController.swift
//  TestRealmMedium
//
//  Created by Elle Ti on 2018-06-12.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit

class RestAPIViewController: UIViewController {
    
    @IBOutlet weak var apiTableView: UITableView!
    var coinsList = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiTableView.dataSource = self
        apiTableView.delegate = self
        
        fetchJSON()
        
    }
    
    struct List: Decodable {
        let coins_info: [Coin]
    }
    
    struct Coin: Decodable {
        let symbol: String?
        let full_name: String?
        let image_url: String?
        let updated_at: Int?
    }
    
    fileprivate func fetchJSON() {
//        let urlString = "http://api.letsbuildthatapp.com/jsondecodable/courses_snake_case"
        let urlString = "http://localhost:3000/v1/coins_infos"
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJkZXZpY2VfaWQiOiJkZXZpY2UxIn0.hJUtGtgmKLdwRHEkjdhmHkrhQWW-Hnluxe6vhQmgALY"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let err = error {
                    print("Failed to get data from url:", err)
                    return
                }
                
                guard let jsonData = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    
                    self.coinsList = try decoder.decode([List].self, from: jsonData)
                    self.apiTableView.reloadData()
                }
                catch let jsonErr {
                    print("Failed to decode", jsonErr)
                }
            }
        }.resume()
    }
    
}

extension RestAPIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = apiTableView.dequeueReusableCell(withIdentifier: "APICell") as! RestAPITableViewCell
        let coinList = coinsList[indexPath.row]

        print("Cell info: \(coinList)")
//        cell.userIDLabel.text = coinList.full_name
//        cell.idLabel.text = coinList.full_name
//        cell.titleLabel.text = coinList.image_url
//        cell.completedLabel.text = coinList.updated_at
        
        return cell
    }
}
