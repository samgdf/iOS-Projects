//
//  ViewController.swift
//  Calculator
//
//  Created by Sam Goldfield on 2/18/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userTyping = true
        }
    }
    
    /*
     let path = UIBezierPath()
     path.move(to: CGPoint(80,50))
     path.addLine(to: CGPoint(140,150))
     path.addLine(to: CGPoint(10,150))
     path.close()
     
     UIColor.green.setFill()
     UIColor.red.setStroke()
     path.lineWidth = 3.0
     path.fill()
     path.stroke()
 */
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userTyping {
            brain.setOperand(displayValue)
            userTyping = false
        }

        if let mathematicalSymbol = sender.currentTitle {
                brain.performOp(mathematicalSymbol)
                   }
        
        if let result = brain.result {
            displayValue = result
        }
    }

    
}

