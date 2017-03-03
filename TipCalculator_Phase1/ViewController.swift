//
//  ViewController.swift
//  TipCalculator_Phase1
//
//  Created by Padmanabhan, Avinash on 3/2/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import UIKit

//class ViewController: UIViewController, MyProtocol {
class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipAmoutLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipPercentSlider: UISlider!
    @IBOutlet weak var tipPercentControl: UISegmentedControl!
    var defaultTipPercent:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.value(forKey: "defaultTipPercent") != nil {
            print("\(UserDefaults.standard.value(forKey: "defaultTipPercent")!)")
            defaultTipPercent = UserDefaults.standard.integer(forKey: "defaultTipPercent")
            tipPercentControl.selectedSegmentIndex = defaultTipPercent!
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showSettingsController" {
//            let settingsViewController = segue.destination as! SettingsViewController
//            settingsViewController.delegate = self
//        }
//    }
    
//    func setDefaultTipPercent(info: Int) {
//        tipPercentControl.selectedSegmentIndex = info
//        print("\(UserDefaults.standard.value(forKey: "user_auth_token")!)")
//    }
    
    @IBAction func calculateTip_SegControl(_ sender: Any) {
        calculateTip_TextField(sender)
    }
    
    @IBAction func calculateTip_TextField(_ sender: Any) {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent

        let inputString : String = inputTextField.text!
        if !(inputString.isEmpty) {
            
            let billAmount = Float(inputString) ?? 0
            billAmountLabel.text = currencyFormatter.string(from: NSNumber(value: billAmount))

            let tipPercentages : [Float] = [0.18, 0.2, 0.25]
            let segValue = tipPercentControl.selectedSegmentIndex
            
            let tipAmount = billAmount * tipPercentages[segValue]
            tipAmoutLabel.text = currencyFormatter.string(from: NSNumber(value: tipAmount))
            
            let totalAmount = billAmount + tipAmount
            totalAmountLabel.text = currencyFormatter.string(from: NSNumber(value: totalAmount))
        } else {
            billAmountLabel.text = ""
            tipAmoutLabel.text = ""
            totalAmountLabel.text = ""
        }

    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
}

