//
//  ViewController.swift
//  Homework 1
//
//  Created by Yiff OSX on 4/18/21.
//

import UIKit

struct MyHealhInfo
{
    init()
    {
        Systolic = 0
        Diastolic = 0
        Weight = 0.0
        Sugar  = 0.0
        OtherInfo = ""
    }
    
    var Systolic : Int
    var Diastolic : Int
    var Weight : Double
    var Sugar : Double
    var OtherInfo : String
}

struct MyApplicationState
{
    init()
    {
        History = [MyHealhInfo]()
    }
    
    var History : [MyHealhInfo]
}

class MainMenuController: UIViewController {
    static var MyState : MyApplicationState = MyApplicationState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

