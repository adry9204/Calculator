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

    //Label outlets
    @IBOutlet weak var CalculationLabel: UILabel!
    @IBOutlet weak var ResultLabel: UILabel!
    
    
    //App's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    //event handlers for when a button is pressed
    @IBAction func EraseBttnPressed(_ sender: UIButton) {}
    
    @IBAction func OperatorBttnPressed(_ sender: UIButton) {}
    
    @IBAction func NumberBttnPressed(_ sender: UIButton) {}
    
    
    
}

