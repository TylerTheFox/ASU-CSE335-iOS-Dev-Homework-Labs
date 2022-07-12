//
//  ViewMyHealthController.swift
//  Homework 1
//
//  Created by Yiff OSX on 4/18/21.
//

import UIKit

class ViewMyHealthController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Table View Setup / Delagates -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    @IBOutlet var MyTableView: UITableView!
    
    
    // Cell Syle
    class MyHealthCells : UITableViewCell
    {
        public let cellView : UIView =
        {
            let view = UIView()
            
            view.backgroundColor = UIColor.gray
            view.layer.cornerRadius = 10
            
            return view
        }()
    
        public let Day : UILabel =
        {
            let label = UILabel()

            label.heightAnchor.constraint(equalToConstant: 200).isActive = true
            label.widthAnchor.constraint(equalToConstant: 60).isActive = true
            
            return label
        }()
        
        public let Systolic : UILabel =
        {
            let label = UILabel()

            label.heightAnchor.constraint(equalToConstant: 200).isActive = true
            label.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return label
        }()
        
        public let Diastolic : UILabel =
        {
            let label = UILabel()
            
            label.heightAnchor.constraint(equalToConstant: 200).isActive = true
            label.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            return label
        }()
        
        public let Weight : UILabel =
        {
            let label = UILabel()

            label.heightAnchor.constraint(equalToConstant: 200).isActive = true
            label.widthAnchor.constraint(equalToConstant: 200).isActive = true
            
            return label
        }()
        
        public let Sugar : UILabel =
        {
            let label = UILabel()
            
            label.heightAnchor.constraint(equalToConstant: 200).isActive = true
            label.widthAnchor.constraint(equalToConstant: 200).isActive = true
            
            return label
        }()
        
        public let OtherInfo : UITextView =
        {
            let textview = UITextView()
            textview.translatesAutoresizingMaskIntoConstraints = false
            
            textview.heightAnchor.constraint(equalToConstant: 90).isActive = true
            textview.widthAnchor.constraint(equalToConstant: 300).isActive = true
            
            return textview
        }()
        
        public func setData(TheDay : Int, HealthData : MyHealhInfo)
        {
            Day.text        = "Day: " + String(TheDay)
            Systolic.text   = String(HealthData.Systolic) + " / "
            Diastolic.text  = String(HealthData.Diastolic)
            Weight.text     = "Weight: " + String(HealthData.Weight) + " Pounds"
            Sugar.text      = "Sugar: " + String(HealthData.Sugar) + " mg"
            OtherInfo.text  = HealthData.OtherInfo
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            addSubview(cellView)
            
            addSubview(Day)
            addSubview(Systolic)
            addSubview(Diastolic)
            addSubview(Weight)
            addSubview(Sugar)
            addSubview(OtherInfo)
            
            self.selectionStyle = .none
            
            // Annoying Apple Bullshit
            //cellView.translatesAutoresizingMaskIntoConstraints = false
            Day.translatesAutoresizingMaskIntoConstraints = false
            Systolic.translatesAutoresizingMaskIntoConstraints = false
            Diastolic.translatesAutoresizingMaskIntoConstraints = false
            Weight.translatesAutoresizingMaskIntoConstraints = false
            Sugar.translatesAutoresizingMaskIntoConstraints = false
            OtherInfo.translatesAutoresizingMaskIntoConstraints = false
            
            // Constaints
            NSLayoutConstraint.activate([
                cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
                cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

            // Componets Constaints

            // Day //
            Day.centerYAnchor.constraint(equalTo: cellView.topAnchor, constant: 25).isActive = true
            Day.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
            //
            
            // Systolic //
            Systolic.centerYAnchor.constraint(equalTo: cellView.topAnchor, constant: 25).isActive = true
            Systolic.rightAnchor.constraint(equalTo: cellView.leftAnchor, constant: 300).isActive = true
            //
            
            // Diastolic //
            Diastolic.centerYAnchor.constraint(equalTo: cellView.topAnchor, constant: 25).isActive = true
            Diastolic.rightAnchor.constraint(equalTo: cellView.leftAnchor, constant: 360).isActive = true
            //
            
            // Weight //
            Weight.centerYAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 25*2).isActive = true
            Weight.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
            //
            
            // Sugar //
            Sugar.centerYAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 25*3).isActive = true
            Sugar.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
            //
            
            // OtherInfo //
            OtherInfo.centerYAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 25*5+20).isActive = true
            OtherInfo.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
            //
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    func setupTableView()
    {
        MyTableView.delegate = self
        MyTableView.dataSource = self
        MyTableView.register(MyHealthCells.self, forCellReuseIdentifier: "yiff")
        view.addSubview(MyTableView)
        
        
        MyTableView.reloadData()
    }
    
    // Cell Height
    internal func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
    
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (MainMenuController.MyState.History.count > 7)
        {
            return 7
        }
        return MainMenuController.MyState.History.count
    }
    
    // Custom Styling
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let data = tableView.dequeueReusableCell(withIdentifier: "yiff", for: indexPath) as! MyHealthCells
        
        let numRows = MainMenuController.MyState.History.count
        let currRow = indexPath.row
        
        var currentIdx : Int = currRow
        var theDay : Int =  currentIdx + 1
        
        if (numRows > 7)
        {
            currentIdx = (numRows - (7 + 1)) + currRow
            //                           ^ Index starts at 0
            
            theDay = currentIdx + 1
        }
        
        data.setData(TheDay: theDay, HealthData: MainMenuController.MyState.History[currentIdx])
        return data
    }
    
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
}
