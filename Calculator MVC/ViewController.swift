//
//  ViewController.swift
//  Calculator MVC
//
//  Created by Power on 28/04/2021.
//  Copyright © 2021 Abdullah Shahid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation : Operation = .noOperation
    let formatter = NumberFormatter()
    var isRunningNumbernegative = false
    
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLbl.text = "0"
        for button in buttons{
            button.layer.cornerRadius = button.frame.height/2
        }
    }

    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.tag)"
            showRunningNumber()
        }
    }
    
    @IBAction func allClearPressed(_ sender: UIButton) {
        allClear()
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        dotpressed()
    }
    
    @IBAction func plusMinusPressed(_ sender: UIButton) {
        togglePlusMinus()
    }
    
   
    @IBAction func percentagePressed(_ sender: UIButton) {
        percentage()
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func subtractPressed(_ sender: UIButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        operation(operation: .Add)
    }
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func dividePressed(_ sender: UIButton) {
        operation(operation: .Divide)
    }
    
}


extension ViewController{
    

    func showRunningNumber(){
        outputLbl.text = runningNumber
    }
    
    func showtResult(){
        if result.count>=9{
            formatter.numberStyle = .scientific
            formatter.positiveFormat = "0.###E0"
            formatter.exponentSymbol = "e"
            result = formatter.string(from: Double(result)! as NSNumber)!
            
        }
        else if Double(result)?.truncatingRemainder(dividingBy: 1) == 0{
            result = "\(Int(Double(result)!))"
        }
        //outputLbl.text = String(result.prefix(9))
        outputLbl.text = result
    }
    
    func allClear(){
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .noOperation
        outputLbl.text = "0"
    }
    
    enum Operation : String {
        case Add
        case Subtract
        case Multiply
        case Divide
        case Percentage
        case noOperation
    }
    
    func operation(operation : Operation){
        if currentOperation != .noOperation{ // Their is already an operation in process/happening
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                calculations()
                
                showtResult()
                leftValue = result
            }
            currentOperation = operation
        }
        else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    
    func calculations(){
        
        if currentOperation == .Add{
            result = "\(Double(leftValue)! + Double(rightValue)!)"
        }
        else if currentOperation == .Subtract {
            result = "\(Double(leftValue)! - Double(rightValue)!)"
        }
        else if currentOperation == .Multiply{
            result = "\(Double(leftValue)! * Double(rightValue)!)"
        }
        else if currentOperation == .Divide{
            result = "\(Double(leftValue)! / Double(rightValue)!)"
        }
    
    }
    
    func dotpressed(){
        if runningNumber.count == 0{
            runningNumber += "0."
            showRunningNumber()
        }
        else if runningNumber.contains("."){
        }
        else if runningNumber.count <= 7{
            runningNumber += "."
            showRunningNumber()
        }
    }
    
    func togglePlusMinus(){
            
            if isRunningNumbernegative && runningNumber.count != 0{
                runningNumber.removeFirst()
                isRunningNumbernegative = false
            }
           else{
            if runningNumber.count == 0{
                runningNumber = "-"
                isRunningNumbernegative = true
            }
            else{
                runningNumber = "-" + runningNumber
                isRunningNumbernegative = true
            }
        }
            showRunningNumber()
    }
    
    func percentage(){
        if runningNumber != ""{
            runningNumber = "\(Double(runningNumber)!/100)"
            result = runningNumber
        showtResult()
        }
        else if result != "" {
            result = "\(Double(result)!/100)"
            showtResult()
        }
    }
}


