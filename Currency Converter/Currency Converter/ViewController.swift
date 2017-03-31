//
//  ViewController.swift
//  Currency Converter
//
//  Created by Sam Goldfield on 3/31/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var activeCurrency:Double = 0;

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var output: UILabel!
    
    //create picker view
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
    }
    
    @IBAction func action(_ sender: Any) {
        if (input.text != "") {
            output.text = String(Double(input.text!)! * activeCurrency)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get data
        
        let url = URL(string: "http://api.fixer.io/latest") //allow abritrary load from security if not HTTPS
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("ERROR")
            } else {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary {
                            for(key,value) in rates {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                            
                            //what it do
                        }
                    } catch {
                        
                    }
                }
            }
            self.pickerview.reloadAllComponents()
        }
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

