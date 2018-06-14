//
//  ViewController.swift
//  TestRealmMedium
//
//  Created by Elle Ti on 6/5/18.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit
import RealmSwift

//var coins: Results<Coin>!

var realm = try! Realm()

class ViewController: UIViewController {
    
//    coinNameLabel, coinSymbolLabel
    
    @IBOutlet weak var tableView: UITableView!
    var tableViewDataSource = [CoinTokens]()
    var itemList = [CoinTokens]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        coins = realm.objects(Coin.self)
        
//        let manager = CoinManager.init()
//        itemList = manager.tokenList
        
        tableViewDataSource = itemList
        
        tableView.dataSource = self
        tableView.delegate = self
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }

    func reloadData() {
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let coin = tableViewDataSource[indexPath.row]
        
//        let manager = APIManager()
////        print("Coin info: \(coin)")
//
//        manager.getTokenInfo { (info, error) in
//
//            cell.coinNameLabel.text = info?.full_name
//            cell.coinSymbolLabel.text = info?.symbol
//            cell.imageURLLabel.text = info?.image_url
//        }
        
        cell.coinNameLabel.text = coin.full_name
        cell.coinSymbolLabel.text = coin.symbol?.uppercased()
        cell.imageURLLabel.text = coin.image_url
        cell.timeLabel.text = "\(String(describing: coin.updated_at))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class Coin: Object {
    @objc dynamic var symbol = ""
    @objc dynamic var timeStamp = 0
}

extension ViewController: NewSelectTokenDelegate {
    func addButtonPressed(name: String, symbol: String, url: String, time: Double) {
        let tokenName = name, tokenSymbol = symbol, tokenURL = url, tokenTime = time
        print("Token name = %@, symbol = %@, url = %@, time = %@", tokenName, tokenSymbol, tokenURL, tokenTime)
    }
    
}

