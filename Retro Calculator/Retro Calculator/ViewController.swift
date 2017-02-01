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
        
        presentNumber += "\(sender.tag)"
        counterLabel.text = presentNumber
        
        playSound()
        
        
    }

    
    @IBAction func onEqualPress(sender: UIButton){
        
        
    }
    
    @IBAction func onAddPress(sender: UIButton){
        
        print ("\n__TAG \(presentNumber)\n")
        
        
        processOperation(operation: Operation.Add)
    }
    @IBAction func onSubtractPress(sender: UIButton){
        
    }
    @IBAction func onMultiplyPress(sender: UIButton){
        
    }
    @IBAction func onDevidePress(sender: UIButton){
        
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
    
    
    func processOperation(operation :Operation){
        
        
        
        if operation != Operation.Empty{
            
            
            
            
            if presentNumber != ""  {
                
                
                
                rightNumber = presentNumber
                
           
                
                print ("\npresent = \(presentNumber) \nright=\(rightNumber) \nleft = \(leftNumber)")
                
                
                
                if operation == Operation.Add {
                    result  = "\(Double(leftNumber)! + (Double(rightNumber))!)"
                    
                }
                
                
                counterLabel.text = result
                leftNumber = result
                
                
                presentNumber = "";
                
                
                currentOperation = Operation.Empty;
                
            }
            
            
            
        }
        
        
    }
    
    
    
    
    

}

