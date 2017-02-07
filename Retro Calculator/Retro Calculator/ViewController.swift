//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Mehedee Hassan on 12/24/16.
//  Copyright © 2016 Mehedee Hassan. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    
    var buttonSound: AVAudioPlayer!
    
    
    
    @IBOutlet weak var counterLabel: UILabel!
    
    
    
    
    
    enum Operation : String {
        
        case Division = "/"
        case Multiply  = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty  = "NIL"
    }
    
    
    enum PressedFlag :Int {
        case Number = 1
        case Operator = 2
        case Equal = 3
        
        case EqualAfterOperator = 4
        case EqualAfterNumber = 5
        
        
        case OperatorAfterEqual = 6
        case OperatorAfterNumber = 7
        case OperatorAfterOperator = 8
        
        
        case Empty = -1
    }
    
    
    
    
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let path = Bundle.main.path(forResource: "btn",ofType: "wav")
        
        let soundUrl = URL(fileURLWithPath: path!)
        
        
        
        do{
            
            try buttonSound = AVAudioPlayer(contentsOf : soundUrl)
            buttonSound.play()
            
        } catch let err as NSError{
            print (err.debugDescription)
        }
        
        
        
        
    }


    
    var currentOperation = Operation.Empty

    var rightNumber = "";
    
    var leftNumber = "";
    var presentNumber = ""
    
    var result = "";
    var __op = Operation.Empty;
    
    var _NumOpNum = -1
    
    
    var equalPressed = false
    var calculatorTurnedOn = true
    var pressedFlag = PressedFlag.Empty
    
    // 1= number ,2 = operation ,3 = equals
    
    
    
    @IBAction func onNumberPressedPlay(sender: UIButton){
        
        
        
        
        if pressedFlag == PressedFlag.Equal {
            
            presentNumber = ""
            leftNumber = ""
            rightNumber = ""
            result = ""
            
        }
        
        
        
        presentNumber += "\(sender.tag)"
        
        counterLabel.text = presentNumber
        
        playSound()
        
        
        if _NumOpNum == 2{
            _NumOpNum = 3 // chain of number op number op
        }
        else{
            _NumOpNum = 1
        }
        
        
        pressedFlag = PressedFlag.Number
        
    }

    
    @IBAction func onEqualPress(sender: UIButton){
        
        
        
        
        pressedFlag = PressedFlag.Equal
        
       
        
        processEqual()
        
        // no need
        currentOperation = Operation.Empty
        
        //init
        rightNumber = "";
        presentNumber = ""
        result = "";
        
        
        
    }
    
    
    
    @IBAction func onAddPress(sender: UIButton){
        
        print ("\n__TAG \(presentNumber)\n")
        
        
        processOperation(operation: Operation.Add)
    }
    
    
    
    @IBAction func onSubtractPress(sender: UIButton){
          print ("\n__TAG \(presentNumber)\n")
        processOperation(operation: Operation.Subtract)
    }
    
    
    @IBAction func onMultiplyPress(sender: UIButton){
          print ("\n__TAG \(presentNumber)\n")
        processOperation(operation: Operation.Multiply)
    }
    
    
    @IBAction func onDevidePress(sender: UIButton){
          print ("\n__TAG \(presentNumber)\n")
        processOperation(operation: Operation.Division)
    }
    
    
    func playSound(){
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    
   
    
    
    
    func processEqual(){
        
        
        rightNumber = presentNumber
        presentNumber = ""
    
        if pressedFlag == PressedFlag.Equal {
            
            //result  = "\(Double(leftNumber)! * (Double(rightNumber))!)"
            
            
            if currentOperation !=  Operation.Empty{
                
                if rightNumber != "" && leftNumber != ""{
                  
                    performAction()
                    
                    
                    counterLabel.text = result  // lebel text
                    leftNumber = result         //left number is now result
                
                }
                else if rightNumber != ""{
            
                    leftNumber = rightNumber
                
                }
            
            }
            else {
                
                if result != "" {
                
                    counterLabel.text = result  // lebel text
                    leftNumber = result         //left number is now result
                    
                }
                else if rightNumber != "" {
                    
                    counterLabel.text = rightNumber  // lebel text
                    leftNumber = rightNumber         //left number is now present
                    
                }
                
            }
            
            
            
            
        }
        
    }
    
    
    
    
    
    func processOperation(operation :Operation){
        
        currentOperation = operation // set pressed current operation
        rightNumber = presentNumber
        presentNumber = ""
        
        
        
        
        if pressedFlag == PressedFlag.Number {
            
            //result  = "\(Double(leftNumber)! * (Double(rightNumber))!)"
            
            
            
                if rightNumber != "" && leftNumber != ""{
                    
                    performAction()
                    
                    counterLabel.text = result  // lebel text
                    leftNumber = result         //left number is now result
                    
                }
                else if rightNumber != ""{
                    
                    leftNumber = rightNumber
                    
                }
                
            
            
            
            
            
        }else if _NumOpNum == 3 {
            
            if rightNumber != "" && leftNumber != ""{
                
                performAction()
                
                counterLabel.text = result  // lebel text
                leftNumber = result         //left number is now result
                
            }
            else if rightNumber != ""{
                
                leftNumber = rightNumber
                
            }
            
        }
        
        
        
        pressedFlag = PressedFlag.Operator
        _NumOpNum = 2
    
    }
    
    
    
    func performAction(){
    
        
        if currentOperation == Operation.Multiply {
            
            
            result  = "\(Double(leftNumber)! * (Double(rightNumber))!)"
            
            print( "\ndebug1 equal press:\n result   = \(result) \n left = \(leftNumber) \n right= \(rightNumber)" )
        }
            
        else if currentOperation == Operation.Add {
            
            
            result  = "\(Double(leftNumber)! + (Double(rightNumber))!)"
            
            print( "\ndebug1 equal press:\n result   = \(result) \n left = \(leftNumber) \n right= \(rightNumber)" )
        }
            
        else if currentOperation == Operation.Subtract {
            
            
            result  = "\(Double(leftNumber)! - (Double(rightNumber))!)"
            
            print( "\ndebug1 equal press:\n result   = \(result) \n left = \(leftNumber) \n right= \(rightNumber)" )
        }
            
        else if currentOperation == Operation.Division {
            
            
            let tempNumber = Double(rightNumber)!
            
            if tempNumber == 0 {
                
                result = "INF"
                
            }else {
                result  = "\(Double(leftNumber)! / tempNumber)"
                
            }
            
            
            
            print( "\ndebug1 equal press:\n result   = \(result) \n left = \(leftNumber) \n right= \(rightNumber)" )
        }

        
    }
    
    

}

