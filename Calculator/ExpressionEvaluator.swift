//
//  EvaluateExpression.swift
//  Calculator
//
/* Created and Developed by
 
 Adriana Diaz Torres - 301157161
 Aurela Bala - 301279255
 Manmeen Kaur - 301259638
 
 Date Created: 05/10/2022
 Expression Evaluator for our Calculator app. This class handler all the calculation logic, while the ViewController takes care of the user interface.
        It has a public method called calculator, used by the ViewController, as well as 2 auxiliar   methods to handle internal data processing.
 Version:1.2.0
 */

import Foundation
import UIKit

public class ExpressionEvaluator: UIViewController
{
    
    //main method of the ExpressionEvaluator class
    //it divides the expression by the operands and evaluate every single subexpression in the priority order
    static func Evaluate(expression: String) -> String {
        var partialResult : Double = 0
        
        //Split by +
        let addends = expression.split(separator: "+")
        var doubleAddends :[Double] = []
        for addend in addends {
            //Split by -
            let subtractors = addend.split(separator: "-")
            var doubleSubtractors : [Double] = []
            for subtractor in subtractors {
                //Split by x
                let multipliers = subtractor.split(separator: "x")
                var doubleMultipliers : [Double] = []
                for multiplier in multipliers {
                    //Split by /
                    let dividends = multiplier.split(separator: "÷")
                    let doubleDividends = ConvertToArrayOfDouble(origin: dividends)
                    
                    //Calculate divisions
                    partialResult = ResolveSingleOperation(operands: doubleDividends, operation: Operations.Division)
                    doubleMultipliers.append(partialResult)
                }
                //Calculate multiplications
                partialResult = ResolveSingleOperation(operands: doubleMultipliers, operation: Operations.Multiplication)
                doubleSubtractors.append(partialResult)
            }
            //Calculate Subtractions
            partialResult = ResolveSingleOperation(operands: doubleSubtractors, operation: Operations.Subtraction)
            doubleAddends.append(partialResult)
        }
        
        //Calculate Additions
        let result = ResolveSingleOperation(operands: doubleAddends, operation: Operations.Addition)
        
        //elimination the .0 from final string if result is INT
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(Int(result))
        }
        return String(result)
        
       
    }
    
    
    
    //An auxiliar method that iterates on every item of a give array and performs a given operation
    private static func ResolveSingleOperation(operands: [Double], operation: Operations) -> Double {
        var result  = operands[0]
        var index = 1
        
        //iterate the array of strings and apply the corresponding operation to each of them
        while index < operands.count {
            switch operation {
            case Operations.Division:
                result = result / operands[index]
            case Operations.Multiplication:
                result = result * operands[index]
            case Operations.Addition:
                result = result + operands[index]
            default:
                result = result - operands[index]
            }
            
            index += 1
        }
        
        return result
    }
    
    
    //An auxiliar method that copies every element in a [Substring.SubSequence] in a new [String]
    //Is used after the operation "SplitBy(+)" to be able to acces every element in a more flexible format
    static private func ConvertToArrayOfDouble(origin: [Substring.SubSequence]) -> [Double] {
        var doubArray : [Double] = []
        
        for number in origin {
            if number.contains("±") {
                var num = String(number)
                num.removeLast()
                doubArray.append(Double(num)! * (-1))
            } else if number.contains("%") {
                var num = String(number)
                num.removeLast()
                doubArray.append(Double(num)! / 100)
            } else {
            doubArray.append(Double(String(number))!)
            }
        }
        
        return doubArray
    }
    
}


//little enum used only to make refercences to certain operations more intuitive
//is used to tell the ResolvingSingleOperation function which operation should be apply to the numbers in the array
enum Operations {
    case Division
    case Multiplication
    case Addition
    case Subtraction
    
}
