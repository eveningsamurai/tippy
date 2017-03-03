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

    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipAmoutLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentControl: UISegmentedControl!
    @IBOutlet weak var totalTextLabel: UILabel!
    var defaultTipPercent:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        billAmountField.becomeFirstResponder()
        print("Setting first responder")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.value(forKey: "defaultTipPercent") != nil {
            print("restoring tip percent")
            print("\(UserDefaults.standard.value(forKey: "defaultTipPercent")!)")
            defaultTipPercent = UserDefaults.standard.integer(forKey: "defaultTipPercent")
            tipPercentControl.selectedSegmentIndex = defaultTipPercent!
        }
        if UserDefaults.standard.value(forKey: "billAmount") != nil {
            print("restoring bill amount")
            let currentDate = UserDefaults.standard.value(forKey: "currentDate")
            let calculatedDate = UserDefaults.standard.value(forKey: "calculatedDate")
            print("currentDate in setBillAmount: " + String(describing: currentDate))
            print("calculatedDate in ssetBillAmount: " + String(describing: calculatedDate))
            if (currentDate as! Date).compare(calculatedDate as! Date) == ComparisonResult.orderedDescending {
                print("they are order descending)")
            }
            
            billAmountField.text = UserDefaults.standard.value(forKey: "billAmount") as! String?
            tipAmoutLabel.text = "$" + String(calculateTip())
            totalAmountLabel.text = "$" + String(calculateTotal())
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
    
    @IBAction func saveBillAmount_BillAmount(_ sender: Any) {
        print("editing ended")
        let currentDate = NSDate()
        let calendar = Calendar.current
        let calculatedDate = calendar.date(byAdding: .minute, value: 10, to: currentDate as Date)

        if !(billAmountField.text?.isEmpty)! {
            print("storing bill amount")
            print("currentDate in saveBillAmount: " + String(describing: currentDate))
            print("calculatedDate in saveBillAmount: " + String(describing: calculatedDate))
            UserDefaults.standard.set(billAmountField.text, forKey: "billAmount")
            UserDefaults.standard.set(currentDate, forKey: "currentDate")
            UserDefaults.standard.set(calculatedDate, forKey: "calculatedDate")
            UserDefaults.standard.synchronize()
        }
    }
    
    @IBAction func calculateTip_SegControl(_ sender: Any) {
        calculateTip_BillAmount(sender)
    }
    
    @IBAction func calculateTip_BillAmount(_ sender: Any) {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        
        let inputString : String = billAmountField.text!
        if !(inputString.isEmpty) {
            
            let billAmount = Float(inputString) ?? 0
            
            let tipPercentages : [Float] = [0.18, 0.2, 0.25]
            let segValue = tipPercentControl.selectedSegmentIndex
            
            let tipAmount = billAmount * tipPercentages[segValue]
            tipAmoutLabel.text = currencyFormatter.string(from: NSNumber(value: tipAmount))
            
            let totalAmount = billAmount + tipAmount
            totalAmountLabel.text = currencyFormatter.string(from: NSNumber(value: totalAmount))
            
            let animationTextField = CABasicAnimation(keyPath: "position")
            animationTextField.duration = 0.06
            animationTextField.repeatCount = 3
            animationTextField.autoreverses = true
            animationTextField.fromValue = NSValue(cgPoint: CGPoint(x: totalAmountLabel.center.x-10, y:totalAmountLabel.center.y-2))
            animationTextField.toValue = NSValue(cgPoint: CGPoint(x: totalAmountLabel.center.x+10, y: totalAmountLabel.center.y+2))
            totalAmountLabel.layer.add(animationTextField, forKey: "position")
            
            let animationTextLabel = CABasicAnimation(keyPath: "position")
            animationTextLabel.duration = 0.06
            animationTextLabel.repeatCount = 3
            animationTextLabel.autoreverses = true
            animationTextLabel.fromValue = NSValue(cgPoint: CGPoint(x: totalTextLabel.center.x-10, y:totalTextLabel.center.y-2))
            animationTextLabel.toValue = NSValue(cgPoint: CGPoint(x: totalTextLabel.center.x+10, y: totalTextLabel.center.y+2))
            totalTextLabel.layer.add(animationTextLabel, forKey: "position")
        } else {
            billAmountField.text = ""
            tipAmoutLabel.text = ""
            totalAmountLabel.text = ""
        }
    }
    
    func calculateTip() -> Float {
        let inputString : String = billAmountField.text!
        let billAmount = Float(inputString) ?? 0

        let tipPercentages : [Float] = [0.18, 0.2, 0.25]
        let segValue = tipPercentControl.selectedSegmentIndex
        let tipAmount = billAmount * tipPercentages[segValue]
            
        return tipAmount
    }
    
    func calculateTotal() -> Float {
        let tipAmount = calculateTip()
        let inputString : String = billAmountField.text!
        let billAmount = Float(inputString) ?? 0
        
        let totalAmount = billAmount + tipAmount
        return totalAmount
    }
}

