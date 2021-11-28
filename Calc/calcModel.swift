//
//  calcModel.swift
//  Calc
//
//  Created by Бексултан Нурпейс on 20.09.2021.
//

import Foundation


func makeZero(opernd: Double) -> Double{
    return 0
}

enum Operation{
    case constant(Double),unaryOperation((Double)->Double),binaryOperation((Double,Double)->Double),equals
}


struct CalculatorModel {
    var my_operation: Dictionary<String,Operation> =
        [
            "p": Operation.constant(Double.pi),
            "e": Operation.constant(M_E),
            "√": Operation.unaryOperation(sqrt),
            "sin": Operation.unaryOperation(sin),
            "A/C": Operation.unaryOperation(makeZero),
            "+": Operation.binaryOperation({$0+$1}), 
            "-": Operation.binaryOperation({$0-$1}),
            "×": Operation.binaryOperation({$0*$1}),
            "÷": Operation.binaryOperation({$0/$1}),
            "=": Operation.equals
        ]
    
    private var global_value: Double?
    mutating func setOperand(_ operand: Double){
        global_value = operand
    }
    mutating func performOperand(_ operation: String){
        let symbol = my_operation[operation]!
        switch symbol{
        case .constant(let value):
            global_value = value
        case .unaryOperation(let function):
            global_value = function(global_value!)
        case .binaryOperation(let function):
            saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation: function)
        case .equals:
            global_value = saving?.performOperationWith(secondOperand: global_value!)
        }
        
    }
    func getResult()-> Double?{
        return global_value
    }
    private var saving: SaveFirstOperandAndOperation?
    struct SaveFirstOperandAndOperation {
        var firstOperand: Double
        var operation: (Double,Double) -> Double
        
        func performOperationWith(secondOperand op2:Double) -> Double{
            return operation(firstOperand,op2)
        }
    }
}
