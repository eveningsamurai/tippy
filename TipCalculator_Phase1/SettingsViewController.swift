
//  Created by Padmanabhan, Avinash on 3/2/17.
//  Copyright © 2017 Intuit. All rights reserved.

import UIKit

/*
 The commented out lines provide a way to pass information from a controller back to the previous controller without using UserDefaults
 */
//protocol MyProtocol: class {
//    func setDefaultTipPercent(info: Int)
//}

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet weak var defaultSegmentControl: UISegmentedControl!
//    weak var delegate:MyProtocol? = nil
    
    @IBAction func sendDefaultTipPercent(_ sender: Any) {
//        delegate?.setDefaultTipPercent(info: defaultSegmentControl.selectedSegmentIndex)
//        _ = self.navigationController?.popViewController(animated: true)
//        UserDefaults.standard.setValue(defaultSegmentControl.selectedSegmentIndex, forKey: "defaultTipPercent")
        
        UserDefaults.standard.set(defaultSegmentControl.selectedSegmentIndex, forKey: "defaultTipPercent")
        UserDefaults.standard.synchronize()
        print("storing tip percent")
        print("\(UserDefaults.standard.value(forKey: "defaultTipPercent")!)")
    }
    
    @IBAction func controlTheme(_ sender: Any) {
        let themes : [String] = ["default", "light", "dark"]
        UserDefaults.standard.set(themes[themeControl.selectedSegmentIndex], forKey: "theme")
        UserDefaults.standard.synchronize()
        if let theme = UserDefaults.standard.string(forKey: "theme") {
            if theme == "light" {
                self.view.backgroundColor = UIColor.lightGray
                self.defaultSegmentControl.tintColor = UIColor.green
                self.themeControl.tintColor = UIColor.green
            } else if theme == "dark"{
                self.view.backgroundColor = UIColor.darkGray
                self.defaultSegmentControl.tintColor = UIColor.red
                self.themeControl.tintColor = UIColor.red
            } else {
                self.view.backgroundColor = UIColor.white
                self.defaultSegmentControl.tintColor = UIColor.blue
                self.themeControl.tintColor = UIColor.blue
            }
        }
    }
}
