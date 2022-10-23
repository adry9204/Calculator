//
//  ViewController.swift
//  Calculator
//
/* Created and Developed by
 Aurela Bala - 301279255
 Adriana Diaz Torres - 301157161
 Manmeen Kaur - 301259638
 
 Date Created: 19/10/2022
 Advanced Calculator App. It performs all basic operation in accordance with the interface we implemented in version 1.0.0.
 It performs 30 new operations only on landscape mode.
    Addition, Subtraccion, Multiplication, Divition, Percentage and +/-, Clear, Backspace and 30 new operations.
    It allows for combined operations, evaluating them according to the priority rules as well as several data format checks, such as preventing a number to be entered with 2 dots or a number that starts with 00000.
 Version: 1.3.0
 
 */

import UIKit

class ViewController: UIViewController {
    
    //Label outlets
    @IBOutlet weak var CalculationLabel: UILabel!
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var ResultLabelLandscape: UILabel!
    @IBOutlet weak var CalculationLabelLandscape: UILabel!
    
    
    var expression = ""
    //var lastExpression = ""
    
    
    
    //App's Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
   
    }
    
    //clear all function
    func clearAll()
    {
        CalculationLabel.text = "0"
        ResultLabel.text = ""
        CalculationLabelLandscape.text = "0"
        ResultLabelLandscape.text = ""
    }
    
    
    //event handlers for when a button is pressed ( clear all or backbutton )
    @IBAction func EraseBttnPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        
        switch (buttonText) {
        case "C":
            clearAll()
            expression = ""
            //backspace case
        default:
            if(CalculationLabel.text!.count == 1)
            {
                CalculationLabel.text = "0"
                CalculationLabelLandscape.text = "0"
                expression = ""
            }
            
            else
            {
                CalculationLabel.text?.removeLast()
                CalculationLabelLandscape.text?.removeLast()
            }
        }
        
        print(expression)
    }
    
    
    
    //event handlers for when a button is pressed ( operators )
    @IBAction func OperatorBttnPressed(_ sender: UIButton)
    {
        if((CalculationLabel.text?.count == 16) || ((CalculationLabelLandscape.text?.count == 16)))
        { return }
        
        let button = sender as UIButton
        let buttonText = button.titleLabel!.text
        let lastCharacter = CalculationLabel.text?.last.map(String.init)
        
        //allow to exchange one binary operator for other
        if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "÷")
        {
            
            //first number is negative
            if(CalculationLabel.text! == "0" && buttonText == "-")
            {
                CalculationLabel.text = "-"
                return
            }
            
            
            if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷")
            {
                CalculationLabel.text?.removeLast()
                expression.removeLast()
            }
            
            //allow to exchange one unary operator for other
            //avoid the case of unary operator behind binary operator
            if(!isOperationAllowed() && ((buttonText == "+" && lastCharacter == "(" ) || (buttonText == "-" && lastCharacter == "(")  || (buttonText == "x" && lastCharacter == "(") || (buttonText == "÷" && lastCharacter == "(") ) )
            {
                return
            }
            
            
            CalculationLabel.text?.append(buttonText!)
            CalculationLabelLandscape.text = CalculationLabel.text
            expression.append(buttonText!)
            print(expression)
        }

        if(isOperationAllowed() && (buttonText == "%" || buttonText == "±"))
        {
            CalculationLabel.text?.append(buttonText!)
            CalculationLabelLandscape.text = CalculationLabel.text
            expression.append(buttonText!)
            print(expression)
        }
    
    }
    
    
    //allow operator method
    func isOperationAllowed() -> Bool
    {
        
        let lastCharacter = CalculationLabel.text?.last.map(String.init)
        if(lastCharacter == "1" || lastCharacter == "2" || lastCharacter == "3" || lastCharacter == "4" || lastCharacter == "5" || lastCharacter == "6" || lastCharacter == "7" || lastCharacter == "8" || lastCharacter == "9" || lastCharacter == ")" || lastCharacter == "0" )
        {
            return true
        }
        
        return false
    }
    
    
    //event handlers for when a Equal button is pressed
    //calculate the expression using our custom evaluator class
    @IBAction func EqualBttnPressed(_ sender: UIButton)
    {
        //an expression that start with a negative number should be evaluated as 0-expression
        if(CalculationLabel.text!.first == "-"){
            expression = "0" + expression
        }
        
        //removing any unnecessary binary operators at the end of the expression before evaluate
        if(expression.last == "+" || expression.last == "-" || expression.last == "x" || expression.last == "÷")
        {
            expression.removeLast()
            print(expression)
            CalculationLabel.text!.removeLast()
        }
        try! ResultLabel.text = ExpressionEvaluator.Evaluate(expression: expression, radianValues: true, secondOperation: false)
        ResultLabelLandscape.text = ResultLabel.text
    }
    
    
    
    //Event handlers for when a button is pressed ( numbers )
    @IBAction func NumberBttnPressed(_ sender: UIButton)
    {
        if(CalculationLabel.text?.count == 16)
        { return }
        
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabel.text?.last.map(String.init)
        
        if (lastCharacter == "%" || lastCharacter == "±")
        {
            return
        }
        
        switch (buttonText)
        {
        case ".":
            if (lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷" || lastCharacter == "±" || lastCharacter == "%" || lastCharacter == "(" ) {
                CalculationLabel.text?.append("0.")
                CalculationLabelLandscape.text?.append("0.")
            } else {
                if(!lastNumber().contains("."))
                {
                    CalculationLabel.text?.append(buttonText!)
                    CalculationLabelLandscape.text?.append(buttonText!)
                }
            }
        default:
            //fixing the 0 at the beggining of the number (07 -> 7)
            if (lastNumber() == "0") {
                CalculationLabel.text?.removeLast()
                CalculationLabel.text?.append(buttonText!)
                
                CalculationLabelLandscape.text?.removeLast()
                CalculationLabelLandscape.text?.append(buttonText!)
                expression = CalculationLabel.text!
                print(expression)
                return
            }
            
            CalculationLabel.text?.append(buttonText!)
            CalculationLabelLandscape.text?.append(buttonText!)
            expression.append(buttonText!)
        }
        print(expression)
        
    }
    
    
    //returns the last full number inputed in the label (78*3.6+78.03 --> 78.03)
    func lastNumber() -> String
    {
        var index = CalculationLabel.text!.count - 1
        let calculationLabelText: String = CalculationLabel.text!
        let text: [Character] = Array<Character>(calculationLabelText)
        var result = ""
        
        while (index >= 0)
        {
            if (text[index] == "+" || text[index] == "-" || text[index] == "x" || text[index] == "÷" || text[index] == "±" || text[index] == "%") {
                return result
            }
            
            result = String(text[index]) + result
            index -= 1
        }
        return result
    }
    
    
    
    //Event handlers when π button is pressed
    @IBAction func piButtonPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
       
        if(CalculationLabelLandscape.text == "0")
        {
            CalculationLabelLandscape.text = "π"
            CalculationLabel.text = CalculationLabelLandscape.text
            expression += "p"
            //print(expression)
            
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷"  || lastCharacter == "±")
        {
            expression += "p"
            CalculationLabelLandscape.text?.append(buttonText!)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        print(expression)
            
    }
    
    
    //Event handlers when Rand button is pressed
    @IBAction func randButtonPressed(_ sender: UIButton)
    {
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
        //get the random number from the expression evaluator
        let newNumber = try! ExpressionEvaluator.Evaluate(expression: "R", radianValues: true, secondOperation: true)
        let newNumberString = String(newNumber)
        
        if(CalculationLabelLandscape.text == "0")
        {
            CalculationLabelLandscape.text = newNumberString
            CalculationLabel.text = CalculationLabelLandscape.text
            expression.append(newNumberString)
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷"  || lastCharacter == "±")
        {
            expression += newNumberString
            CalculationLabelLandscape.text?.append(newNumberString)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        print(expression)
    }
    
    
    
    //Event handlers when tanh button is pressed
    @IBAction func tanhButtonPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
       
        if(CalculationLabelLandscape.text == "0")
        {
            expression = "0"
            CalculationLabelLandscape.text = "0"
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷")
        {
            return
        }
        
        if(lastCharacter == "±")
        {
            expression.append("o")
            CalculationLabelLandscape.text?.append(buttonText!)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        let numbers = (Int(lastCharacter!))
        if ((numbers) != nil)
        {
           expression.append("o")
           CalculationLabelLandscape.text?.append(buttonText!)
           CalculationLabel.text = CalculationLabelLandscape.text
        }

        print(expression)
    }
    
    
    
    //Event handlers when cosh button is pressed
    @IBAction func coshButtonPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
        if(CalculationLabelLandscape.text == "0")
        {
            expression = "0"
            CalculationLabelLandscape.text = "0"
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷" )
        {
            return
        }
        
        if(lastCharacter == "±")
        {
            expression.append("k")
            CalculationLabelLandscape.text?.append(buttonText!)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        let numbers = (Int(lastCharacter!))
        if ((numbers) != nil)
        {
           expression.append("k")
           CalculationLabelLandscape.text?.append(buttonText!)
           CalculationLabel.text = CalculationLabelLandscape.text
        }
    
        print(expression)
        
    }
    
    
    
    
    //Event handlers when sin button is pressed
    @IBAction func sinhButtonPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
        if(CalculationLabelLandscape.text == "0")
        {
            expression = "0"
            CalculationLabelLandscape.text = "0"
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷" )
        {
            return
        }
        
        if(lastCharacter == "±")
        {
            expression.append("j")
            CalculationLabelLandscape.text?.append(buttonText!)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        let numbers = (Int(lastCharacter!))
        if ((numbers) != nil)
        {
           expression.append("j")
           CalculationLabelLandscape.text?.append(buttonText!)
           CalculationLabel.text = CalculationLabelLandscape.text
        }
    
        print(expression)
        
    }
    
    
    
    //Event handlers when sin button is pressed
    @IBAction func tanButtonPressed(_ sender: UIButton)
    {
        
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
        if(CalculationLabelLandscape.text == "0")
        {
            expression = "0"
            CalculationLabelLandscape.text = "0"
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷")
        {
            return
        }
        
        if(lastCharacter == "±")
        {
            expression.append("i")
            CalculationLabelLandscape.text?.append(buttonText!)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        let numbers = (Int(lastCharacter!))
        if ((numbers) != nil)
        {
           expression.append("i")
           CalculationLabelLandscape.text?.append(buttonText!)
           CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        print(expression)
    }
    
    //Event handlers when cos button is pressed
    
    
    @IBAction func cosButtonPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
        if(CalculationLabelLandscape.text == "0")
        {
            expression = "0"
            CalculationLabelLandscape.text = "0"
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷" )
        {
            return
        }
        
        if(lastCharacter == "±")
        {
            expression.append("h")
            CalculationLabelLandscape.text?.append(buttonText!)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        let numbers = (Int(lastCharacter!))
        if ((numbers) != nil)
        {
           expression.append("h")
           CalculationLabelLandscape.text?.append(buttonText!)
           CalculationLabel.text = CalculationLabelLandscape.text
        }
    
        print(expression)
    }
    
    
    
    //Event handlers when sin button is pressed
    @IBAction func sinButtonPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
        if(CalculationLabelLandscape.text == "0")
        {
            expression = "0"
            CalculationLabelLandscape.text = "0"
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷")
        {
            return
        }
        
        if(lastCharacter == "±")
        {
            expression.append("g")
            CalculationLabelLandscape.text?.append(buttonText!)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
        
        let numbers = (Int(lastCharacter!))
        if ((numbers) != nil)
        {
           expression.append("g")
           CalculationLabelLandscape.text?.append(buttonText!)
           CalculationLabel.text = CalculationLabelLandscape.text
        }
    
        print(expression)
    }
    
    
    
    //Event handlers when x! button is pressed
    @IBAction func factorialButtonPressed(_ sender: UIButton)
    {
        
    }
    
    
    
    //event handlers when open paranthesis button is pressed
    @IBAction func openParenthesisBttnPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
       
        if(CalculationLabelLandscape.text == "0")
        {
           return
        }

        //let numbers = (Int(lastCharacter!))
        if (lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷" || lastCharacter == "%")
        {
           expression.append("(")
           CalculationLabelLandscape.text?.append(buttonText!)
           CalculationLabel.text = CalculationLabelLandscape.text
        }
    
        print(expression)
    }
    
    
    
    //event handlers when an close paranthesis button is pressed
    @IBAction func closeParenthesisBttnPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
        if(CalculationLabelLandscape.text == "0")
        {
            return
        }
        
        if(lastCharacter == "+" || lastCharacter == "-" || lastCharacter == "x" || lastCharacter == "÷" || lastCharacter == "%" || lastCharacter == "±")
        {
            return
        }
        
       
        else
        {
            expression.append(")")
            CalculationLabelLandscape.text?.append(buttonText!)
            CalculationLabel.text = CalculationLabelLandscape.text
        }
    
        print(expression)
    }
    
    
    //event handlers when square root button is pressed
    @IBAction func squareRootBttnPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        let lastCharacter = CalculationLabelLandscape.text?.last.map(String.init)
        
        if(CalculationLabelLandscape.text == "0")
        {
            return
        }
        
        let numbers = (Int(lastCharacter!))
        if (numbers != nil)
        {
           expression.append("√")
           CalculationLabelLandscape.text?.append(buttonText!)
           CalculationLabel.text = CalculationLabelLandscape.text
        }
    
        print(expression)
    }
    
}



