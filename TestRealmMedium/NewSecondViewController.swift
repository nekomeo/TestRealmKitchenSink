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
    
    var itemList = [CoinTokens]()
    var tableViewDataSource = [CoinTokens]()
    var tokenItem: CoinTokens!
    let apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewDataSource = itemList
        print("tableViewDataSource: \(tableViewDataSource)")
        
        listTableView.dataSource = self
        listTableView.delegate = self

        updateValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateValues() {
        let manager = APIManager()
        manager.getTokenInfo { (endpointInfo, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("\nSome error here\n")
                }
                else {
                    print("\nInfo here is...: \(String(describing: endpointInfo))\n")
                }
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.coinDelegate?.addButtonPressed(name: self.tokenItem.full_name!, symbol: self.tokenItem.symbol!, url: self.tokenItem.image_url!, time: Double(self.tokenItem.updated_at!))
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    func buttonPressed(name: String, timeStamp: Double) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension NewSecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "secondTableCell") as! NewSecondViewTableViewCell
        
        apiManager.getTokenInfo { (info, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("An error occurred here in the APIManager")
                }
                if let info = info {
//                    cell.coinNameLabel.text = info.full_name
//                    cell.coinNameSymbol.text = info.symbol?.uppercased()
//                    cell.coinImageURL.text = info.image_url
//                    cell.timeStampLabel.text = "\(String(describing: info.updated_at))"
                    print("Info: \(info)")
                }
            }
        }
        
//        let coin = tableViewDataSource[indexPath.row]
//        cell.coinNameLabel.text = coin.name
//        cell.coinNameSymbol.text = coin.symbol.uppercased()
//        cell.coinImageURL.text = coin.imageURL
//        cell.timeStampLabel.text = "\(coin.timeStamp)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Index: \(indexPath.row)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BackToMain" {
            let vc = segue.destination as! ViewController
            let selectedIP = self.listTableView.indexPathForSelectedRow!
            let row = selectedIP.row
            vc.itemList = [itemList[row]]
            print("Info to pass: \(vc.itemList)")
        }
        
//        let aCoin = Coin()
//        aCoin.name = textField.text!
//        //        aSwitch.isEnabled = aSwitch.isOn
//
//        try! realm.write {
//            realm.add(aCoin)
//        }
//
//        dismiss(animated: true, completion: nil)
    }
}
