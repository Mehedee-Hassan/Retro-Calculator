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
    
    var equalPressed = false
    var calculatorTurnedOn = true
    var pressedFlag = -1 // 1= number ,2 = operation ,3 = equals
    
    
    @IBOutlet weak var counterLabel: UILabel!
    
    
    var presentNumber = ""
    
    
    enum Operation : String {
        
        case Devide = "/"
        case Multiply  = "*"
        case Substract = "-"
        case Add = "+"
        case Empty  = "NIL"
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

    
    
    @IBAction func onNumberPressedPlay(sender: UIButton){
        
        
        if equalPressed == true {
            counterLabel.text = ""
           // result = ""
           // leftNumber = "0"
            equalPressed = false
        
            
            if pressedFlag != 2 {
                leftNumber = "0"
                result = ""
            }
            
        }
        
        
        
        pressedFlag = 1
        
        presentNumber += "\(sender.tag)"
        
        counterLabel.text = presentNumber
        
        playSound()
        
        
    }

    
    @IBAction func onEqualPress(sender: UIButton){
          print ("\n__TAG equal\(presentNumber)\n")
        equalPressed = true
        processEqual()
        
    }
    
    
    
    @IBAction func onAddPress(sender: UIButton){
        
        print ("\n__TAG \(presentNumber)\n")
        
        
        processOperation(operation: Operation.Add)
    }
    
    
    
    @IBAction func onSubtractPress(sender: UIButton){
          print ("\n__TAG \(presentNumber)\n")
        processOperation(operation: Operation.Substract)
    }
    
    
    @IBAction func onMultiplyPress(sender: UIButton){
          print ("\n__TAG \(presentNumber)\n")
        processOperation(operation: Operation.Multiply)
    }
    
    
    @IBAction func onDevidePress(sender: UIButton){
          print ("\n__TAG \(presentNumber)\n")
        processOperation(operation: Operation.Devide)
    }
    
    
    func playSound(){
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    
    var currentOperation = Operation.Empty
    var rightNumber = "";
    var leftNumber = "0";
    var result = "";
    
    var __op = Operation.Empty;
    
    
    
    func processEqual(){
        
       
        
        print ("\npresent = \(presentNumber) \nresult=\(result) ")
        

        
        //counterLabel.text = result
        //leftNumber = result
        
        //presentNumber = result;
        
        //equalPressed = true
        
        
        
        var op = __op;
        
        if op != Operation.Empty {
            
                __op = Operation.Empty
            
                counterLabel.text = ""
                
                
                
                if presentNumber != ""  {
                    
                    
                    
                    rightNumber = presentNumber
                    
                    
                    
                    print ("\npresent = \(presentNumber) \nright=\(rightNumber) \nleft = \(leftNumber)")
                    
                    
                    
                    if op == Operation.Add {
                        result  = "\(Double(leftNumber)! + (Double(rightNumber))!)"
                        
                        op = Operation.Empty
                        
                    }else if op == Operation.Substract {
                        
                        op = Operation.Empty
                        
                        
                        result  = "\(Double(leftNumber)! - (Double(rightNumber))!)"
                        
                    }
                    else if op == Operation.Multiply {
                        
                        op = Operation.Empty
                        
                        result  = "\(Double(leftNumber)! * (Double(rightNumber))!)"
                        
                    }
                    else if op == Operation.Devide{
                        
                        op = Operation.Empty
                        
                        let tempnum = (Double(rightNumber))!
                        
                        
                        if tempnum != 0{
                            result  = "\(Double(leftNumber)! - (Double(rightNumber))!)"
                        }
                        else {
                            result = "INF"
                        }
                        
                        
                    }
                    
                    
                    counterLabel.text = result
                    leftNumber = result
                    
                    
                    presentNumber = "";
                    
                    
                    currentOperation = Operation.Empty;
                    
                }
                
                
                
        }
        
    }
    
    
    
    
    
    func processOperation(operation :Operation){
        
        
        pressedFlag = 2
        
        var op = operation;
        
        if op != Operation.Empty{

            __op = operation
            
            counterLabel.text = ""

            
            
            if leftNumber != ""  && presentNumber != ""{
                
                
                
                rightNumber = presentNumber
                
           
                
                print ("\npresent = \(presentNumber) \nright=\(rightNumber) \nleft = \(leftNumber)")
                
                
                
                if op == Operation.Add {
                    result  = "\(Double(leftNumber)! + (Double(rightNumber))!)"
                    
                    op = Operation.Empty
                    
                }else if op == Operation.Substract {
                    
                    op = Operation.Empty
                    
                    
                    result  = "\(Double(leftNumber)! - (Double(rightNumber))!)"
                    
                }
                else if op == Operation.Multiply {
                    
                    op = Operation.Empty
                    
                    if calculatorTurnedOn == true {
                        calculatorTurnedOn = false
                        result = "\(Double(rightNumber)!)"
                        
                    }else {
                        
                        result  = "\(Double(leftNumber)! * (Double(rightNumber))!)"
                    }
                }
                else if op == Operation.Devide{
                    
                    op = Operation.Empty
                    
                    let tempnum = (Double(rightNumber))!
                    
                    
                    if tempnum != 0{
                        
                        if calculatorTurnedOn == true {
                            calculatorTurnedOn = false
                            result = "\(Double(rightNumber)!)"
                            
                        }else {
                            result  = "\(Double(leftNumber)! - (Double(rightNumber))!)"
                        }
                        
                       
                    }
                    else {
                        result = "INF"
                    }
                    
                    
                }
                
                
                counterLabel.text = result
                leftNumber = result
                
                
                presentNumber = "";
                
                
                currentOperation = Operation.Empty;
                
             }
            
            
            
        }
        
        
    }
    
    
    
    
    

}

