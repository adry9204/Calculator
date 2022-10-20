//
//  ViewController.swift
//  Calculator
//
/* Created and Developed by
 Aurela Bala - 301279255
 Adriana Diaz Torres - 301157161
 Manmeen Kaur - 301259638
 
 Date Created: 5/10/2022
 Simple Calculator App. It performs all basic operation in accordance with the interface we implemented in version 1.0.0.
    Addition, Subtraccion, Multiplication, Divition, Percentage and +/-, Clear and Backspace
    It allows for combined operations, evaluating them according to the priority rules as well as several data format checks, such as preventing a number to be entered with 2 dots or a number that starts with 00000.
 Version: 1.2.0
 
 */

import UIKit

class ViewController: UIViewController {
    
    //Label outlets
    @IBOutlet weak var CalculationLabel: UILabel!
    @IBOutlet weak var ResultLabel: UILabel!
    
    //App's Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //clear all function
    func clearAll() {
        CalculationLabel.text = "0"
        ResultLabel.text = ""
    }
    
    
    //event handlers for when a button is pressed ( clear all or backbutton )
    @IBAction func EraseBttnPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        
        switch (buttonText) {
        case "C":
            clearAll()
            //backspace case
        default:
            if(CalculationLabel.text!.count == 1)
            {
                CalculationLabel.text = "0"
            }
            else
            {
                CalculationLabel.text?.removeLast()
            }
        }
    }
    
    
    
    //event handlers for when a button is pressed ( operators )
    @IBAction func OperatorBttnPressed(_ sender: UIButton)
    {
        if(CalculationLabel.text?.count == 16)
        { return }
        
        let button = sender as UIButton
        let buttonText = button.titleLabel!.text
        let lastCharacter = CalculationLabel.text?.last.map(String.init)
        
        //allow to exchange one binary operator for other
        if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "÷") {
            
            //first number is negative
            if(CalculationLabel.text! == "0" && buttonText == "-") {
                CalculationLabel.text = "-"
                return
            }
            
            
            if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷") {
                CalculationLabel.text?.removeLast()
            }
            //allow to exchange one unary operator for other
            //avoid the case of unary operator behind binary operator
        } else if(buttonText == "±" || buttonText == "%") {
            if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷") {
                return
            }
            if (lastCharacter == "±" || lastCharacter == "%"){
                CalculationLabel.text?.removeLast()
            }
        }
        
        //add new character to calculation label
        CalculationLabel.text?.append(buttonText!)
    }
    
    
    //event handlers for when a Equal button is pressed
    //calculate the expression using our custom evaluator class
    @IBAction func EqualBttnPressed(_ sender: UIButton) {
        var expression = CalculationLabel.text!
        
        //an expression that start with a negative number should be evaluated as 0-expressio
        if(CalculationLabel.text!.first == "-"){
            expression = "0" + expression
        }
        
        //removing any unnecessary binary operators at the end of the expression before evaluate
        if(expression.last == "+" || expression.last == "-" || expression.last == "x" || expression.last == "÷") {
            expression.removeLast()
            print(expression)
            CalculationLabel.text!.removeLast()
        }
        ResultLabel.text = ExpressionEvaluator.Evaluate(expression: expression)
    }
    
    //Event handlers for when a button is pressed ( numbers )
    @IBAction func NumberBttnPressed(_ sender: UIButton)
    {
        if(CalculationLabel.text?.count == 16)
        { return }
        
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabel.text?.last.map(String.init)
        
        if (lastCharacter == "%" || lastCharacter == "±") {
            return
        }
        
        switch (buttonText)
        {
        case ".":
            if (lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷" || lastCharacter == "±" || lastCharacter == "%") {
                CalculationLabel.text?.append("0.")
            } else {
                if(!lastNumber().contains("."))
                {
                    CalculationLabel.text?.append(buttonText!)
                }
            }
        default:
            //fixing the 0 at the beggining of the number (07 -> 7)
            if (lastNumber() == "0") {
                CalculationLabel.text?.removeLast()
                CalculationLabel.text?.append(buttonText!)
                return
            }
            
            CalculationLabel.text?.append(buttonText!)

        }
    }
    
    //returns the las full number inputed in the label (78*3.6+78.03 --> 78.03)
    func lastNumber() -> String {
        var index = CalculationLabel.text!.count - 1
        let calculationLabelText: String = CalculationLabel.text!
        let text: [Character] = Array<Character>(calculationLabelText)
        var result = ""
        
        while (index >= 0) {
            if (text[index] == "+" || text[index] == "-" || text[index] == "x" || text[index] == "÷" || text[index] == "±" || text[index] == "%") {
                return result
            }
            
            result = String(text[index]) + result
            index -= 1
        }
        return result
    }
    
}
