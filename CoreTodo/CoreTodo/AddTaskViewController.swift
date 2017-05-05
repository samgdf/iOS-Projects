//
//  AddTaskViewController.swift
//  CoreTodo
//
//  Created by Sam Goldfield on 5/3/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isImp: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Task(context: context)
        task.name = textField.text!
        task.isImportant = isImp.isOn
        
        //MARK: SAVE DATA
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }

}
