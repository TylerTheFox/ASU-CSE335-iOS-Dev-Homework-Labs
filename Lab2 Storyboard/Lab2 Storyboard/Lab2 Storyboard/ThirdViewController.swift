//
//  ThirdViewController.swift
//  Lab2 Storyboard
//
//  Created by Yiff OSX on 2/7/21.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var EarthMessage: UILabel!
    @IBOutlet weak var MoonMessage: UILabel!
    @IBOutlet weak var JupiterMEssage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vc = self.storyboard?.instantiateViewController(identifier: "first") as? ViewController else
        {
            print("failed to get vc from storyboard")
            return
        }
        
        vc.last_state = 2
        
        let moon_weight = Int(Double(vc.weight) * 0.16667)
        let jupitor_weight = Int(Double(vc.weight) * 2.4)
        
        EarthMessage.text = "Your weight on Earth is " + String(vc.weight)
        MoonMessage.text = "Your weight on Moon is " + String(moon_weight)
        JupiterMEssage.text = "Your weight on Jupiter is " + String(jupitor_weight)
    }
    

    @IBAction func gotoEarth()
    {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "first") as? ViewController else
        {
            print("failed to get vc from storyboard")
            return
        }
        vc.updateLabels()
        present(vc, animated: true)
    }
    
    @IBAction func gotoMoon()
    {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "second") as? SecondViewController else
        {
            print("failed to get vc from storyboard")
            return
        }
        
        present(vc, animated: true)
    }

}
