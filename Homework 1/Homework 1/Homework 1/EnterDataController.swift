//
//  EnterDataController.swift
//  Homework 1
//
//  Created by Yiff OSX on 4/18/21.
//

import UIKit

class EnterDataController: UIViewController {

    var HealthData : MyHealhInfo = MyHealhInfo();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var InputSys: UITextField!
    @IBOutlet weak var InputDia: UITextField!
    @IBOutlet weak var InputWeight: UITextField!
    @IBOutlet weak var InputSugar: UITextField!
    @IBOutlet weak var InputOther: UITextView!
    
    @IBAction func AddButton(_ sender: Any) {
        HealthData.Systolic = Int(InputSys.text!) ?? 0
        HealthData.Diastolic = Int(InputDia.text!) ?? 0
        HealthData.Weight = Double(InputWeight.text!) ?? 0
        HealthData.Sugar = Double(InputSugar.text!) ?? 0
        HealthData.OtherInfo = InputOther.text ?? ""
        MainMenuController.MyState.History.append(HealthData)
        
        performSegue(withIdentifier: "MainMenuFromEnterData", sender: nil)
    }
    

}
