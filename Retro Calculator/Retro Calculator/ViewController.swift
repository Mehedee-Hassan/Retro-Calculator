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
    
    
    var presentNumber = ""
    
    
    enum Operation : String {
        
        case Division = "/"
        case Multiply  = "*"
        case Subtract = "-"
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


    
    var currentOperation = Operation.Empty
    var rightNumber = "0";
    var leftNumber = "0";
    var result = "0";
    var __op = Operation.Empty;

    
    
    var equalPressed = false
    var calculatorTurnedOn = true
    var pressedFlag = -1 // 1= number ,2 = operation ,3 = equals
    
    
    
    @IBAction func onNumberPressedPlay(sender: UIButton){
        
        
        
        presentNumber += "\(sender.tag)"
        
        counterLabel.text = presentNumber
        
        playSound()
        
        
        pressedFlag = 1 // number pressed
        
    }

    
    @IBAction func onEqualPress(sender: UIButton){
        
        
        
        
        if pressedFlag == 1{
            pressedFlag = 3 // number before equal
        }
        else if pressedFlag == 2{
            pressedFlag = 5 // operator before equal
        }
        else if pressedFlag == -1 {
            pressedFlag = 6 // equal pressed first time
        }
        
        processEqual()
        
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
    
    
   
    
    
    
    func processEqual(){}
    
    
    
    
    
    func processOperation(operation :Operation){}
    
    
    
    
    

}

