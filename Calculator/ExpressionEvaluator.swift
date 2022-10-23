//
//  ViewController.swift
//  Calculator
//
/* Created and Developed by
 Aurela Bala - 301279255
 Adriana Diaz Torres - 301157161
 Manmeen Kaur - 301259638
 
 Date Created: 5/10/2022
 Date Updated: 23/10/2022
Scientific Calculator App. It performs all operation in accordance with the interface we implemented in version 1.0.0. that has been updated to support 30 new operations on landscape mode
    It allows for combined operations, evaluating them according to the priority rules as well as several data format checks, such as preventing a number to be entered with 2 dots or a number that starts with 00000. Parenthesis allow for priority changes and nested operations.
 Exceptions are handled
 Version: 1.3.0
 
 */


import Foundation
import UIKit

public class ExpressionEvaluator: UIViewController
{
    private static var mem = 0.0
    private static var rads = false
    private static var second = false
    
    //new method to find () and make sure they are balanced
    static func Evaluate(expression: String, radianValues: Bool, secondOperation: Bool) throws -> String {
        second = secondOperation
        rads = radianValues
        var solution = ""
        
        if expression.contains("(") {
            let firstPos = expression.firstIndex(of: "(")
            let subExpression = getInnerExpression(expression: String(expression.suffix(from: firstPos!)))
            try solution = Evaluate(expression: subExpression, radianValues: radianValues, secondOperation: secondOperation)
            //copying everything before + value + after the ()
            var finalExpression = String(expression.prefix(upTo: firstPos!))
            let suffixLength = expression.count - (finalExpression.count + (subExpression.count + 2))
            finalExpression += solution
            finalExpression += String(expression.suffix(suffixLength))
            try solution = Evaluate(expression: finalExpression , radianValues: radianValues, secondOperation: secondOperation)
            
        } else {
            try solution = Resolve(expression: expression)
            
        }
     
        return solution
    }
    
    //main method of the ExpressionEvaluator class
    //it divides the expression by the operands and evaluate every single subexpression in the priority order
    static func Resolve(expression: String) throws -> String {
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
                    do {
                        let doubleDividends = try ConvertToArrayOfDouble(origin: dividends)
                        
                        //Calculate divisions
                        partialResult = ResolveSingleOperation(operands: doubleDividends, operation: Operations.Division)
                        doubleMultipliers.append(partialResult)
                    } catch ExpressionErrors.FactorialDouble, ExpressionErrors.UnknownExpression
                    {
                        print("My Error")
                        throw ExpressionErrors.FactorialDouble
                    }
                        
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
        if result > Double(Int.max) {
            return String(result)
        } else if (result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(Int(result))
        }
        
        return String(result)
        
       
    }
    
    
    
    //An auxiliar method that iterates on every item of a give array and performs a given operation
    private static func ResolveSingleOperation(operands: [Double], operation: Operations) -> Double {
        if operands.count == 0 {
            return 0
        }
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
    static private func ConvertToArrayOfDouble(origin: [Substring.SubSequence]) throws -> [Double] {
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
            } else if number.contains("√"){
                var num = String(number)
                num.removeLast()
                doubArray.append(Double(num)!.squareRoot())
            } else if number.contains("a"){
                var num = String(number)
                num.removeLast()
                doubArray.append(cbrt(Double(num)!))
            } else if number.contains("f"){
                var num = String(number)
                num.removeLast()
                doubArray.append(1/Double(num)!)
            } else if number.contains("l"){
                var num = String(number)
                num.removeLast()
                doubArray.append(log(Double(num)!))
            } else if number.contains("t"){
                var num = String(number)
                num.removeLast()
                doubArray.append(log10(Double(num)!))
            } else if number.contains("!"){
                var num = String(number)
                num.removeLast()
                var newNumber = Double(num)!
                if newNumber.truncatingRemainder(dividingBy: 1) == 0 {
                    newNumber = FactorialCalculator(number:newNumber)
                    doubArray.append(newNumber)
                } else {
                    throw ExpressionErrors.FactorialDouble
                }
            } else if number.contains("s"){
                var num = String(number)
                num.removeLast()
                doubArray.append(Double(num)!*Double(num)!)
            } else if number.contains("b"){
                var num = String(number)
                num.removeLast()
                doubArray.append(Double(num)!*Double(num)!*Double(num)!)
            } else if number.contains("c"){
                var num = String(number)
                num.removeLast()
                doubArray.append(pow(10, Double(num)!))
            } else if number.contains("d"){
                var num = String(number)
                num.removeLast()
                doubArray.append(pow(2.718281828459045, Double(num)!))
            } else if number.contains("g"){
                var num = String(number)
                num.removeLast()
                if second {
                    if rads {
                        doubArray.append(asin(Double(num)!))
                    } else {
                        doubArray.append(asin(Double(num)!) * 180 / Double.pi )
                    }
                } else {
                    if rads {
                        doubArray.append(sin(Double(num)!))
                    } else {
                        doubArray.append(sin(Double(num)! * Double.pi / 180))
                    }
                }
            } else if number.contains("h"){
                var num = String(number)
                num.removeLast()
                if second {
                    if rads {
                        doubArray.append(acos(Double(num)!))
                    } else {
                        doubArray.append(acos(Double(num)!) * 180 / Double.pi)
                    }
                } else {
                    if rads {
                        doubArray.append(cos(Double(num)!))
                    } else {
                        doubArray.append(cos(Double(num)! * Double.pi / 180))
                    }
                }
            } else if number.contains("i"){
                var num = String(number)
                num.removeLast()
                if second {
                    if rads {
                        doubArray.append(atan(Double(num)!))
                    } else {
                        doubArray.append(atan(Double(num)!) * 180 / Double.pi)
                    }
                } else {
                    if rads {
                    doubArray.append(tan(Double(num)!))
                    } else {
                        doubArray.append(tan(Double(num)! * Double.pi / 180))
                    }
                }
            } else if number.contains("j"){
                var num = String(number)
                num.removeLast()
                if second {
                    doubArray.append(asinh(Double(num)!))
                } else {
                    doubArray.append(sinh(Double(num)!))
                }
            } else if number.contains("k"){
                var num = String(number)
                num.removeLast()
                if second {
                    doubArray.append(acosh(Double(num)!))
                } else {
                    doubArray.append(cosh(Double(num)!))
                }
            } else if number.contains("o"){
                var num = String(number)
                num.removeLast()
                if second {
                    doubArray.append(atanh(Double(num)!))
                } else {
                    doubArray.append(tanh(Double(num)!))
                }
            } else if number.contains("e"){
                doubArray.append(2.718281828459045)
            }else if number.contains("p"){
                doubArray.append(3.141592653589793)
            } else if number.contains("z"){
                let nums = number
                let x = nums.split(separator: "z").first
                let y = nums.split(separator: "z").last
                doubArray.append(pow(Double(x!)!, 1 / Double(y!)!))
            } else if number.contains("y"){
                let nums = number
                let x = nums.split(separator: "y").first
                let y = nums.split(separator: "y").last
                doubArray.append(pow(Double(x!)!, Double(y!)!))
            } else if number.contains("E"){
                let nums = number
                let x = nums.split(separator: "E").first
                let y = nums.split(separator: "E").last
                doubArray.append(Double(x!)! * pow(10, Double(y!)!))
            } else if number.contains("R"){
                doubArray.append(round(Double.random(in: 0.0...1.0) * 100) / 100)
            } else if number.contains("m"){
                doubArray.append(mem)
            } else if number.contains("n"){
                mem = 0.0
            } else if number.contains("q"){
                var num = String(number)
                num.removeLast()
                mem += Double(num)!
            } else if number.contains("r"){
                var num = String(number)
                num.removeLast()
                mem -= Double(num)!
            } else {
            doubArray.append(Double(String(number))!)
            }
        }
        
        return doubArray
    }
    
    private static func FactorialCalculator(number: Double) -> Double {
        if number == 1 {
            return number
        }
        
        return number * FactorialCalculator(number: number - 1)
        
    }
    
    //geting the outer most expression for recursive evaluation
    private static func getInnerExpression(expression: String) -> String {
        var balance = 0
        var newExpression = ""
        
        for character in expression {
            if character == "(" {
                balance += 1
            } else if character == ")" {
                balance -= 1
            }
            
            newExpression += String(character)
            
            if balance == 0 {
                break
            }
        }
        
        newExpression.removeFirst()
        newExpression.removeLast()
        return newExpression
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

enum ExpressionErrors: Error {
    case FactorialDouble
    case UnknownExpression
    case InvalidSin
}

