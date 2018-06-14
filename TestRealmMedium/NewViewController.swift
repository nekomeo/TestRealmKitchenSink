//
//  NewViewController.swift
//  TestRealmMedium
//
//  Created by Elle Ti on 6/5/18.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit
import RealmSwift

class NewViewController: UIViewController {
    
    let incomingCoin: Coin? = nil
//    let realm = try! Realm()

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var aSwitch: UISwitch!
    
    @IBAction func doneButton(_ sender: UIButton) {
//        let aCoin = Coin()
//        aCoin.name = textField.text!
        //        aSwitch.isEnabled = aSwitch.isOn
        
//        try! realm.write {
//            realm.add(aCoin)
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
