//
//  AmIAtRiskController.swift
//  Homework 1
//
//  Created by Yiff OSX on 4/18/21.
//

import UIKit

class AmIAtRiskController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var MyHealthWarnings : [String] = [String]()
    
    @IBOutlet weak var MainNavBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateWarnings()
        setupTableView()
    }
    
    func calculateWarnings()
    {
        MyHealthWarnings.removeAll()
        
        var AverageWeightFirst3 : Double = 0.0
        var AverageWeightLast4 : Double = 0.0
        var BloodSuger10Higher: Bool = false
        var HighBloodPrssure: Bool = false
        
        let myHealthData = MainMenuController.MyState.History
        let myHealthDataCount = MainMenuController.MyState.History.count
        
        var currentIdx : Int = 0
        
        // Calculate average weight
        if (myHealthDataCount > 4)
        {
            currentIdx = (myHealthDataCount - 4)
        }
        
        var currentCount = 0
        var totalWeight : Double = 0.0
        for i in currentIdx ..< myHealthDataCount
        {
            totalWeight += myHealthData[i].Weight
            currentCount += 1
        }
        AverageWeightLast4 = totalWeight / Double(currentCount)
        
        currentCount = 0
        currentIdx = 0
        totalWeight = 0
        
        for i in currentIdx ..< myHealthDataCount
        {
            if (i == 3)
            {
                break
            }
            totalWeight += myHealthData[i].Weight
            currentCount += 1
        }
        AverageWeightFirst3 = totalWeight / Double(currentCount)
        
        if (myHealthDataCount > 1)
        {
            var lastDay = myHealthData[myHealthDataCount - 1].Sugar
            var SecondToLastDay = myHealthData[myHealthDataCount - 2].Sugar
        
            var percentIncease = 100 * ((lastDay - SecondToLastDay)/abs(lastDay))
            
            if (percentIncease > 10)
            {
                BloodSuger10Higher = true
            }
            
            lastDay = Double(myHealthData[myHealthDataCount - 1].Systolic)
            SecondToLastDay = Double(myHealthData[myHealthDataCount - 2].Systolic)
        
            percentIncease = 100 * ((lastDay - SecondToLastDay)/abs(lastDay))
            
            if (percentIncease > 10)
            {
                HighBloodPrssure = true
            }
            
            lastDay = Double(myHealthData[myHealthDataCount - 1].Diastolic)
            SecondToLastDay = Double(myHealthData[myHealthDataCount - 2].Diastolic)
        
            percentIncease = 100 * ((lastDay - SecondToLastDay)/abs(lastDay))
            
            if (percentIncease > 10)
            {
                HighBloodPrssure = true
            }
        }
    
        
        if (AverageWeightLast4 > AverageWeightFirst3)
        {
            MyHealthWarnings.append("You are gaining weight!")
        }
        
        if (BloodSuger10Higher)
        {
            MyHealthWarnings.append("Your sugar level is high!")
        }
        
        if (HighBloodPrssure)
        {
            MyHealthWarnings.append("Your blood pressure is high!")
        }
        
        if ((AverageWeightLast4 <= AverageWeightFirst3) && !BloodSuger10Higher && !HighBloodPrssure)
        {
            MyHealthWarnings.append("You are in good health,")
            MyHealthWarnings.append("keep up the good work! :)")
        }
        
        MyTableView.reloadData()
    }
    
    @IBOutlet var MyTableView: UITableView!
    
    func setupTableView()
    {
        MyTableView.delegate = self
        MyTableView.dataSource = self
        MyTableView.register(MyWarningCell.self, forCellReuseIdentifier: "yiff")
        view.addSubview(MyTableView)
        
        
        MyTableView.reloadData()
    }
    
    
    // Cell Syle
    class MyWarningCell : UITableViewCell
    {
        public let cellView : UIView =
        {
            let view = UIView()
            
            view.backgroundColor = UIColor.gray
            view.layer.cornerRadius = 10
            
            return view
        }()
    
        public let MyWarning : UILabel =
        {
            let label = UILabel()

            label.heightAnchor.constraint(equalToConstant: 200).isActive = true
            label.widthAnchor.constraint(equalToConstant: 300).isActive = true
            
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            addSubview(cellView)
            
            addSubview(MyWarning)
            
            self.selectionStyle = .none
            
            // Annoying Apple Bullshit
            //cellView.translatesAutoresizingMaskIntoConstraints = false
            MyWarning.translatesAutoresizingMaskIntoConstraints = false

            // Constaints
            NSLayoutConstraint.activate([
                cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
                cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

            // Componets Constaints

            // Day //
            MyWarning.centerYAnchor.constraint(equalTo: cellView.topAnchor, constant: 25).isActive = true
            MyWarning.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    // Cell Height
    internal func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65
    }
    
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MyHealthWarnings.count
    }
    
    // Custom Styling
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let data = tableView.dequeueReusableCell(withIdentifier: "yiff", for: indexPath) as! MyWarningCell
        data.MyWarning.text = MyHealthWarnings[indexPath.row]
        return data
    }
}
