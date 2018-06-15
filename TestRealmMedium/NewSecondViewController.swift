//
//  NewSecondViewController.swift
//  TestRealmMedium
//
//  Created by Elle Ti on 6/8/18.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit

protocol NewSelectTokenDelegate: class {
    func addButtonPressed(name: String, symbol: String, url: String, time: Double)
}

class NewSecondViewController: UIViewController {
    
    public weak var coinDelegate: NewSelectTokenDelegate?

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    
    var coinArray = [CoinTokens]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.dataSource = self
        listTableView.delegate = self

        updateValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateValues() {
        let serverAddress = URL(string: "http://localhost:3000/v1/coins_infos")
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJkZXZpY2VfaWQiOiJkZXZpY2UxIn0.hJUtGtgmKLdwRHEkjdhmHkrhQWW-Hnluxe6vhQmgALY"
        
        var request = URLRequest(url: serverAddress!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, AnyObject>
            print("JSON Data \(String(describing: jsonData))")
            
            do {
                let decoder = JSONDecoder()
                let downloadedTokens = try decoder.decode([String:[CoinTokens]].self, from: data!)
                
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }
            catch {
                print("Something went wrong after download")
            }
        }.resume()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
    }
    
    func buttonPressed(name: String, timeStamp: Double) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension NewSecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "secondTableCell") as! NewSecondViewTableViewCell
        
//        apiManager.getTokenInfo { (info, error) in
//            DispatchQueue.main.async {
//                if error != nil {
//                    print("An error occurred here in the APIManager")
//                }
//                if let info = info {
//                    print("Info: \(info)")
//                }
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Index: \(indexPath.row)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
