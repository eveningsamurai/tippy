
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

    @IBOutlet weak var defaultSegmentControl: UISegmentedControl!
//    weak var delegate:MyProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendDefaultTipPercent(_ sender: Any) {
//        delegate?.setDefaultTipPercent(info: defaultSegmentControl.selectedSegmentIndex)
//        _ = self.navigationController?.popViewController(animated: true)
//        UserDefaults.standard.setValue(defaultSegmentControl.selectedSegmentIndex, forKey: "defaultTipPercent")
        
        UserDefaults.standard.set(defaultSegmentControl.selectedSegmentIndex, forKey: "defaultTipPercent")
        print("\(UserDefaults.standard.value(forKey: "defaultTipPercent")!)")
    }
    
}
