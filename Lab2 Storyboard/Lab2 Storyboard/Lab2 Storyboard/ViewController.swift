//
//  ViewController.swift
//  Lab2 Storyboard
//
//  Created by Yiff OSX on 2/7/21.
//

import UIKit

class ViewController: UIViewController {
    public var weight  = 0
    public var last_state  = 0
    @IBOutlet weak var HomeMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (last_state == 1)
        {
            HomeMessage.text = "Coming Home from Moon"
        }
        
        if (last_state == 2)
        {
            HomeMessage.text = "Coming Home from Jupiter"
        }
    }
    
    @IBAction   func updateLabels()
    {
        if (last_state == 1)
        {
            HomeMessage.text = "Coming Home from Moon"
        }
        
        if (last_state == 2)
        {
            HomeMessage.text = "Coming Home from Jupiter"
        }
    }

    @IBAction func didTapButton()
    {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "second") as? SecondViewController else
        {
            print("failed to get vc from storyboard")
            return
        }
        
        present(vc, animated: true)
    }

}

