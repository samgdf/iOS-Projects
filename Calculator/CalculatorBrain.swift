//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Sam Goldfield on 2/20/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import Foundation

struct CalculatorBrain { //auto initializer as a struct, class needs init and gets heap unlike struct which is copy write as it only changes if it gets copied and changed
    
    private var accum: Double? //internal gets private, ? makes optional
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [ //generic type, any key to any value, hashable
        "pi" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "sq" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "sign" : Operation.unaryOperation({ -$0 }),
        "x" : Operation.binaryOperation({ $0 * $1 }),
        "/" : Operation.binaryOperation({ $0 / $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "=" : Operation.equals
    ]
    
    mutating func performOp(_ symbol: String) { //if you change the data make it mutating
        if let operation = operations[symbol]{ //returns optional because may not be in table so if let
            switch operation {
            case .constant(let value):
                accum = value
            case .unaryOperation(let function):
                if accum != nil {
                accum = function(accum!)
                }
            case .binaryOperation(let function):
                if accum != nil {
                    pbo = pendingBinaryOp(function: function, firstOperand: accum!)
                    accum = nil
                }
            case .equals:
                performPendingBinaryOp()
            }
        }
    }
    
    private mutating func performPendingBinaryOp() {
        if pbo != nil && accum != nil {
            accum = pbo!.perform(with:accum!)
            pbo = nil
        }
    }
    
    private var pbo: pendingBinaryOp?
    
    private struct pendingBinaryOp {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accum = operand
    }
    
    var result: Double? { //if not set
        get { //to make read only var
            return accum
        }
    }
}
