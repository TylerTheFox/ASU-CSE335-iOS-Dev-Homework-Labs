//
//  ViewController.swift
//  Lab 4
//
//  Created by Yiff OSX on 2/24/21.
//

import UIKit

struct CityStruct
{
    var name : String
    var description : String
    var picture : UIImage
}

var TheAmazingCityDataStructureOMGLikeWow = [CityStruct]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var idkmenusuchwow: UINavigationBar!
    
    let tableview : UITableView = {
        let tv = UITableView();
        tv.backgroundColor = UIColor.white;
        tv.translatesAutoresizingMaskIntoConstraints =  false;
        return tv;
    }();
    
    class KinkyCells : UITableViewCell
    {
        public let cellView : UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.gray
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        public var CityName : UILabel = {
            let label = UILabel()
            label.textColor = UIColor.orange
            return label
        }()
        
        public var CityImage : UIImageView =
        {
            let cm = UIImageView()
            
            cm.frame = CGRect(x: 50, y: 10, width: 50, height: 50)
            
            return cm
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            addSubview(cellView)
            addSubview(CityImage)
            addSubview(CityName)
            self.selectionStyle = .none
            
            NSLayoutConstraint.activate([
                cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
                cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
            
            CityName.translatesAutoresizingMaskIntoConstraints = false
            CityName.heightAnchor.constraint(equalToConstant: 200).isActive = true
            CityName.widthAnchor.constraint(equalToConstant: 200).isActive = true
            CityName.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
            CityName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 150).isActive = true
            
            CityImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
            CityImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
            CityImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
            CityImage.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 100).isActive = true
            CityImage.backgroundColor = UIColor.red
        }
        
        required init?(coder aDEcoder: NSCoder)
        {
            fatalError("rofl");
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        let cs1 = CityStruct(name: "Porltand", description: "asdf", picture: UIImage(named: "moon.jpg")!);
        let cs2 = CityStruct(name: "Austin", description: "fdsa", picture: UIImage(named: "earth.jpg")!);
        let cs3 = CityStruct(name: "New York", description: "uwu", picture: UIImage(named: "mars.png")!);
        let cs4 = CityStruct(name: "Pheonix", description: "asdf", picture: UIImage(named: "moon.jpg")!);
        let cs5 = CityStruct(name: "Seattle", description: "fdsa", picture: UIImage(named: "earth.jpg")!);
        
        TheAmazingCityDataStructureOMGLikeWow.append(cs1)
        TheAmazingCityDataStructureOMGLikeWow.append(cs2)
        TheAmazingCityDataStructureOMGLikeWow.append(cs3)
        TheAmazingCityDataStructureOMGLikeWow.append(cs4)
        TheAmazingCityDataStructureOMGLikeWow.append(cs5)
    
        setupTableView();
        
    }
    
    func setupTableView()
    {
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.register(UITableViewCell.self, forCellReuseIdentifier:  "cellId");
        tableview.register(KinkyCells.self, forCellReuseIdentifier: "cellId");
        view.addSubview(tableview);
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: idkmenusuchwow.bottomAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ]);
        
    }
    
    internal func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TheAmazingCityDataStructureOMGLikeWow.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! KinkyCells
        
        cell.CityName.text = TheAmazingCityDataStructureOMGLikeWow[indexPath.row].name
        cell.CityImage.image = TheAmazingCityDataStructureOMGLikeWow[indexPath.row].picture
        
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    
    @IBOutlet weak var DetailedViewPage: UIView!
    @IBOutlet weak var DetailedImageView: UIImageView!
    
    @IBOutlet weak var DetailedCityName: UILabel!
    @IBOutlet weak var DetailedDescriptoin: UILabel!
    var selectedidx : Int = 0
    
    @IBAction func DetailedClose(_ sender: Any)
    {
        DetailedViewPage.isHidden = true
        tableview.isHidden = false
    }
    
    @IBAction func DeleteCity(_ sender: Any) {
        TheAmazingCityDataStructureOMGLikeWow.remove(at: selectedidx)
        tableview.reloadData()
        DetailedViewPage.isHidden = true
        tableview.isHidden = false
    }
    
    @IBOutlet weak var FuckingAddThingBox: UIView!
    @IBOutlet weak var CityDescriptionInput: UITextField!
    @IBOutlet weak var CityNameInput: UITextField!
    
    @IBAction func AddButton(_ sender: Any) {
        
        let cs1 = CityStruct(name: CityNameInput.text!, description: CityDescriptionInput.text!, picture: UIImage(named: "moon.jpg")!);
        TheAmazingCityDataStructureOMGLikeWow.append(cs1)
        tableview.reloadData()
        FuckingAddThingBox.isHidden = true
        tableview.isHidden = false
        
        CityNameInput.text = ""
        CityDescriptionInput.text = ""
    }
    
    @IBAction func AddButtonThing(_ sender: Any) {
        FuckingAddThingBox.isHidden = false
        tableview.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedidx = indexPath.row
        
        DetailedCityName.text = TheAmazingCityDataStructureOMGLikeWow[selectedidx].name
        DetailedDescriptoin.text = TheAmazingCityDataStructureOMGLikeWow[selectedidx].description
        DetailedImageView.image = TheAmazingCityDataStructureOMGLikeWow[selectedidx].picture
    
        DetailedViewPage.isHidden = false
        tableView.isHidden = true
        
        print(indexPath.row)
    }

}

