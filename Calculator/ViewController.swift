//
//  ViewController.swift
//  Calculator
//
//  Created by Adriana Diaz Torres on 9/20/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CalculationLabel: UILabel!
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var clearAll_Button: UIButton!
    @IBOutlet weak var back_Button: UIButton!
    @IBOutlet weak var plusMinus_Button: UIButton!
    @IBOutlet weak var percent_Button: UIButton!
    @IBOutlet weak var divide_Button: UIButton!
    @IBOutlet weak var multiply_Button: UIButton!
    @IBOutlet weak var subtract_Button: UIButton!
    @IBOutlet weak var add_Button: UIButton!
    @IBOutlet weak var equal_Button: UIButton!
    @IBOutlet weak var numberOne_Button: UIButton!
    @IBOutlet weak var numberTwo_Button: UIButton!
    @IBOutlet weak var numberThree_Button: UIButton!
    @IBOutlet weak var numberFour_Button: UIButton!
    @IBOutlet weak var numberFive_Button: UIButton!
    @IBOutlet weak var numberSix_Button: UIButton!
    @IBOutlet weak var numberSeven_Button: UIButton!
    @IBOutlet weak var numberEight_Button: UIButton!
    @IBOutlet weak var numberNine_Button: UIButton!
    @IBOutlet weak var numberZero_Button: UIButton!
    @IBOutlet weak var decimal_Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //custom circle buttons
        clearAll_Button.layer.cornerRadius = clearAll_Button.frame.width / 2
        clearAll_Button.layer.masksToBounds = true
        plusMinus_Button.layer.cornerRadius = plusMinus_Button.frame.width / 2
        plusMinus_Button.layer.masksToBounds = true
        percent_Button.layer.cornerRadius = percent_Button.frame.width / 2
        percent_Button.layer.masksToBounds = true
        divide_Button.layer.cornerRadius = divide_Button.frame.width / 2
        divide_Button.layer.masksToBounds = true
        multiply_Button.layer.cornerRadius = multiply_Button.frame.width / 2
        multiply_Button.layer.masksToBounds = true
        add_Button.layer.cornerRadius = add_Button.frame.width / 2
        add_Button.layer.masksToBounds = true
        subtract_Button.layer.cornerRadius = subtract_Button.frame.width / 2
        subtract_Button.layer.masksToBounds = true
        back_Button.layer.cornerRadius = back_Button.frame.width / 2
        back_Button.layer.masksToBounds = true
        equal_Button.layer.cornerRadius = equal_Button.frame.width / 2
        equal_Button.layer.masksToBounds = true
        
        //custom rounded buttons
        numberOne_Button.layer.cornerRadius = 15
        numberOne_Button.layer.masksToBounds = true
        numberTwo_Button.layer.cornerRadius = 15
        numberTwo_Button.layer.masksToBounds = true
        numberThree_Button.layer.cornerRadius = 15
        numberThree_Button.layer.masksToBounds = true
        numberFour_Button.layer.cornerRadius = 15
        numberFour_Button.layer.masksToBounds = true
        numberFive_Button.layer.cornerRadius = 15
        numberFive_Button.layer.masksToBounds = true
        numberSix_Button.layer.cornerRadius = 15
        numberSix_Button.layer.masksToBounds = true
        numberSeven_Button.layer.cornerRadius = 15
        numberSeven_Button.layer.masksToBounds = true
        numberEight_Button.layer.cornerRadius = 15
        numberEight_Button.layer.masksToBounds = true
        numberNine_Button.layer.cornerRadius = 15
        numberNine_Button.layer.masksToBounds = true
        numberZero_Button.layer.cornerRadius = 15
        numberZero_Button.layer.masksToBounds = true
        decimal_Button.layer.cornerRadius = 15
        decimal_Button.layer.masksToBounds = true
        
        
        
    }


}

