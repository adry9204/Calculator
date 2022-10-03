//
//  ViewController.swift
//  Calculator
//
/* Created and Developed by
    Aurela Bala - 301279255
    Adriana Diaz Torres - 301157161
    Manmeen Kaur - 301259638
    
    Date Created: 20/09/2022
    Simple Calculator App. It will implement all basic mathematical operations, as well as a Clear and Backspace button in portrait mode. In landscape mode, it will feature a scientific calculator. It has a custom design.
    Verion: 1.0.0
 
 */



import UIKit

class ViewController: UIViewController {
    var calculation_operator: String = ""
    
    
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
        calculation_operator = ""
        
    }
    

    
    
   
    
    //event handlers for when a button is pressed ( clear all or backbutton )
    @IBAction func EraseBttnPressed(_ sender: UIButton)
    {
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        
        switch (buttonText) {
        case "C":
        clearAll()
           
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
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
        
        
        switch (buttonText)
        {
        case "+":

            calculation_operator = "+"
            CalculationLabel.text?.append(calculation_operator)
           
        case "-":
            calculation_operator = "-"
            CalculationLabel.text?.append(calculation_operator)
            
        case "x":
            calculation_operator = "x"
            CalculationLabel.text?.append(calculation_operator)
           
        case "÷":
            calculation_operator = "÷"
            CalculationLabel.text?.append(calculation_operator)
           
        case "%":
            calculation_operator = "%"
            CalculationLabel.text?.append(calculation_operator)
            
        case "+/-":
            calculation_operator = "+/-"
            CalculationLabel.text?.append(calculation_operator)
            
        case "=":
           print("Do the calculation")
            
        default:
           
            print("Nan")
            
        }
    }
    
    
    //event handlers for when a button is pressed ( numbers )
    @IBAction func NumberBttnPressed(_ sender: UIButton)
    {
       
        let button = sender as UIButton
        let buttonText = button.titleLabel?.text
                    
        
        switch (buttonText)
        {
        case ".":
            if(!CalculationLabel.text!.contains("."))
            {
                CalculationLabel.text?.append(buttonText!)
            }
            
        default:
            if(CalculationLabel.text == "0")
            {
                CalculationLabel.text = buttonText
            }
            
            else
            {
                CalculationLabel.text?.append(buttonText!)
                
            }
            
        }
        
    }
    
    
    
}

