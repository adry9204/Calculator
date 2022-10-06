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
 
public class EvaluateExpression: UIViewController
{
    
    func calcevaluate(calculation_expression: String!)
    {
        //Trying to divide a string into substrings using "" as separator.
        let calcExpression = calculation_expression.components(separatedBy: "")
        
        let operands = [] as NSMutableArray //array to store operands (numbers or decimal)
        
        let operators = [] as NSMutableArray // array to store operators
        var i = 0
        
        for i in 0..<calcExpression.count
        {
            if(calcExpression[i] == "")
            {
                continue
            }
        }
        
        if ((calcExpression[i] >= "0" && calcExpression[i] <= "9") || calcExpression[i] == ".")
        {
            var subExpression = ""
            
            while ((calcExpression[i] >= "0" && calcExpression[i] <= "9") || calcExpression[i] == ".")
            {
                i += 1
                subExpression = subExpression + calcExpression[i]
            }
            
            //Trying to insert operands into the operands array.
            operands.insert(subExpression, at: i)
            i -= 1
        }
        else if (calcExpression[i] == "+" || calcExpression[i] == "-" || calcExpression[i] == "*" || calcExpression[i] == "/")
        {
            //Trying to create priority function for the operators.
        }
        
        
    }
}
