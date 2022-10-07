//
//  EvaluateExpression.swift
//  Calculator
//
/* Created and Developed by
 
 Adriana Diaz Torres - 301157161
 Aurela Bala - 301279255
 Manmeen Kaur - 301259638
 
 Date Created: 05/10/2022
 
 */

import Foundation
import UIKit

public class ExpressionEvaluator: UIViewController
{
    
    //main method of the ExpressionEvaluator class
    //it divides the expression by the operands and evaluate every single subexpression in the priority order
    static func Evaluate(expression: String) -> String {
        
        var partialResult : String = ""
        
        //Split by +
        let addends = expression.split(separator: "+")
        var stringAddends :[String] = []
        for addend in addends {
            //Split by -
            let subtractors = addend.split(separator: "-")
            var stringSubtractors : [String] = []
            for subtractor in subtractors {
                //Split by x
                let multipliers = subtractor.split(separator: "x")
                var stringMultipliers : [String] = []
                for multiplier in multipliers {
                    //Split by /
                    let dividends = multiplier.split(separator: "÷")
                    let stringDividends = ConvertToStringArray(origin: dividends)
                    //Calculate divisions
                    partialResult = ResolveSingleOperation(dividends: stringDividends, operation: Operations.Division)
                    stringMultipliers.append(partialResult)
                }
                //Calculate multiplications
                partialResult = ResolveSingleOperation(dividends: stringMultipliers, operation: Operations.Multiplication)
                stringSubtractors.append(partialResult)
            }
            //Calculate Subtractions
            partialResult = ResolveSingleOperation(dividends: stringSubtractors, operation: Operations.Subtraction)
            stringAddends.append(partialResult)
        }
        
        //Calculate Additions
        return ResolveSingleOperation(dividends: stringAddends, operation: Operations.Addition)
    }
    
    
    //An auxiliar method that iterates on every item of a give array and performs a given operation
    private static func ResolveSingleOperation(dividends: [String], operation: Operations) -> String {
        var result  = Double(dividends[0])!
        var index = 1
        
        //iterate the array of strings and apply the corresponding operation to each of them
        while index < dividends.count {
            switch operation {
            case Operations.Division:
                result = result / Double(dividends[index])!
            case Operations.Multiplication:
                result = result * Double(dividends[index])!
            case Operations.Addition:
                result = result + Double(dividends[index])!
            default:
                result = result - Double(dividends[index])!
            }
            
            index += 1
        }
        
        //elimination the .0 from final string if result is INT
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(Int(result))
        }
        return String(result)
    }
    
    
    //An auxiliar method that copies every element in a [Substring.SubSequence] in a new [String]
    //Is used after the operation "SplitBy(+)" to be able to acces every element in a more flexible format
    static private func ConvertToStringArray(origin: [Substring.SubSequence]) -> [String] {
        var strArray : [String] = []
        
        for number in origin {
            strArray.append(String(number))
        }
        
        return strArray
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
