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
    var itemList = [CoinTokens]()
    var tableViewDataSource = [CoinTokens]()
    var tokenItem: CoinTokens!
    var coinName: String?
    var coinSymbol: String?
    var coinImageURL: String?
    var coinUpdateDate: Double?
    
    let jsonURL = "https://jsonplaceholder.typicode.com/todos/"

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: jsonURL) else {
            print("Error: cannot create URL")
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in

            // Check for any errors
            guard error == nil else {
                print("Error calling GET on /todos/1")
                print(error!)
                return
            }

            // Make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }

            // Parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("Error trying to convert data to JSON")
                    return
                }
                // Now we have the Todo. Let's just print it to prove we can access it
                print("The todo is: " + todo.description)

                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            }
            catch {
                print("Error trying to convert the data to JSON")
                return
            }
        }
        task.resume()
    }

}

extension RestAPIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = apiTableView.dequeueReusableCell(withIdentifier: "APICell") as! RestAPITableViewCell
        let coin = tableViewDataSource[indexPath.row]
        cell.userIDLabel.text = coin.full_name
        cell.idLabel.text = coin.symbol
        cell.titleLabel.text = coin.image_url
        cell.completedLabel.text = "\(coin.updated_at)"
        
        return cell
    }
}
