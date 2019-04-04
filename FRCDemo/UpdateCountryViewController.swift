//
//  UpdateCountryViewController.swift
//  FRCDemo
//
//  Created by SHILEI CUI on 4/3/19.
//  Copyright © 2019 @mit. All rights reserved.
//

import UIKit

class UpdateCountryViewController: UIViewController {


    @IBOutlet weak var curField: UITextField!
    @IBOutlet weak var popuField: UITextField!
    @IBOutlet weak var locField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    var name : String?
    var location :String?
    var population : String?
    var currency : String?
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curField.text = currency
        popuField.text = population
        locField.text = location
        nameField.text = name
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateBtnClick(_ sender: UIButton) {
        if !(nameField.text?.isEmpty)! && !(popuField.text?.isEmpty)! && !(locField.text?.isEmpty)! && !(curField.text?.isEmpty)! {
            DataManager.shared.updateCountry(name: nameField.text!, currency: curField.text!, location: locField.text!, population: popuField.text!, index : index!)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
