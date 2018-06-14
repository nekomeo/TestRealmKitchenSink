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
    var coins = [Coin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiTableView.dataSource = self
        apiTableView.delegate = self
        
        fetchJSON()
        
    }
    
    struct Coin: Codable {
        let symbol: String?
        let full_name: String?
        let image_url: String?
        let updated_at: String?
    }
    
    fileprivate func fetchJSON() {
        let urlString = "http://api.letsbuildthatapp.com/jsondecodable/courses_snake_case"
    }
    
}

extension RestAPIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = apiTableView.dequeueReusableCell(withIdentifier: "APICell") as! RestAPITableViewCell
        
        
        return cell
    }
}
