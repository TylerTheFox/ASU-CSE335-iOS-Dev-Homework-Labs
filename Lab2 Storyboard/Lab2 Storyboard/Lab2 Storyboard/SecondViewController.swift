//
//  SecondViewController.swift
//  Lab2 Storyboard
//
//  Created by Yiff OSX on 2/7/21.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var EarthLabel: UILabel!
    @IBOutlet weak var MoonLabel: UILabel!
    @IBOutlet weak var MoonTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let vc = self.storyboard?.instantiateViewController(identifier: "first") as? ViewController else
        {
            print("failed to get vc from storyboard")
            return
        }
        
        if (vc.last_state == 2)
        {
            MoonTitle.text = "Coming from the Jupiter"
        }
        
        vc.last_state = 1
        
        let moon_weight = Int(Double(vc.weight) * 0.16667)
        
        EarthLabel.text = "Your weight on Earth is " + String(vc.weight)
        MoonLabel.text = "Your weight on Moon is " + String(moon_weight)
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
    
    @IBAction func gotoJupiter()
    {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "third") as? ThirdViewController else
        {
            print("failed to get vc from storyboard")
            return
        }
        
        present(vc, animated: true)
    }
}
