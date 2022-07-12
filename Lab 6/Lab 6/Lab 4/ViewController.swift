//
//  ViewController.swift
//  Lab 4
//
//  Created by Yiff OSX on 2/24/21.
//

import UIKit
import MapKit

struct CityStruct
{
    var name : String
    var description : String
    var lat : Double
    var long : Double
}

var TheAmazingCityDataStructureOMGLikeWow = [CityStruct]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var idkmenusuchwow: UINavigationBar!
    @IBOutlet weak var YiffyMap: MKMapView!
    @IBOutlet weak var SearchBoxUI: UIView!
    @IBOutlet weak var SearchBoxInput: UITextField!
    
    func addAllMarkersToMap()
    {
        for city in TheAmazingCityDataStructureOMGLikeWow
        {
            let anno = MKPointAnnotation()
            anno.title = city.name
            anno.subtitle = city.description
            anno.coordinate.latitude = city.lat
            anno.coordinate.longitude = city.long
            YiffyMap.addAnnotation(anno)
        }
    }
    
    func clearAllMarkersFromMap()
    {
        YiffyMap.removeAnnotations(YiffyMap.annotations)
    }
    
    func resyncMap()
    {
        clearAllMarkersFromMap()
        processSearchItems()
    }
    
    func processSearchItems()
    {
        if (SearchBoxInput.text?.count ?? 0 > 0)
        {
            clearAllMarkersFromMap()
            for city in TheAmazingCityDataStructureOMGLikeWow
            {
                if (city.name.contains(SearchBoxInput.text ?? ""))
                {
                    let anno = MKPointAnnotation()
                    anno.title = city.name
                    anno.subtitle = city.description
                    anno.coordinate.latitude = city.lat
                    anno.coordinate.longitude = city.long
                    YiffyMap.addAnnotation(anno)
                }
            }
        }
        else
        {
            addAllMarkersToMap()
        }
    }

    
    @IBAction func SearchButtonPressed(_ sender: Any)
    {
        processSearchItems()
    }
    
    
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
        
        public var CityLat : UILabel = {
            let label = UILabel()
            label.textColor = UIColor.blue
            return label
        }()
        
        public var CityLon : UILabel = {
            let label = UILabel()
            label.textColor = UIColor.green
            return label
        }()
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            addSubview(cellView)
            addSubview(CityName)
            addSubview(CityLat)
            addSubview(CityLon)
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
            CityName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 50).isActive = true
            
            CityLat.translatesAutoresizingMaskIntoConstraints = false
            CityLat.heightAnchor.constraint(equalToConstant: 200).isActive = true
            CityLat.widthAnchor.constraint(equalToConstant: 200).isActive = true
            CityLat.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: 25).isActive = true
            CityLat.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 50).isActive = true

            CityLon.translatesAutoresizingMaskIntoConstraints = false
            CityLon.heightAnchor.constraint(equalToConstant: 250).isActive = true
            CityLon.widthAnchor.constraint(equalToConstant: 200).isActive = true
            CityLon.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: 25).isActive = true
            CityLon.leftAnchor.constraint(equalTo: cellView.rightAnchor, constant: -150).isActive = true
        }
        
        required init?(coder aDEcoder: NSCoder)
        {
            fatalError("rofl");
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTableView()
        setupMap()
    }
    
    func setupMap()
    {
        let coords = CLLocationCoordinate2DMake(33.4255, -111.94)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coords, span: span)
        YiffyMap.setRegion(region, animated: true)
    }
    
    func setupTableView()
    {
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.register(UITableViewCell.self, forCellReuseIdentifier:  "cellId");
        tableview.register(KinkyCells.self, forCellReuseIdentifier: "cellId");
        view.addSubview(tableview);
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: SearchBoxUI.bottomAnchor),
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
        
        cell.CityLat.text = String(format: "%0.5f", TheAmazingCityDataStructureOMGLikeWow[indexPath.row].lat)
        cell.CityLon.text = String(format: "%0.5f", TheAmazingCityDataStructureOMGLikeWow[indexPath.row].long)
        
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    
    @IBOutlet weak var DetailedViewPage: UIView!
    @IBOutlet weak var DetailedCityName: UILabel!
    @IBOutlet weak var DetailedDescriptoin: UILabel!
    var selectedidx : Int = 0
    
    var satView : Bool = false
    @IBAction func SwitchMapModes(_ sender: Any)
    {
        if (satView)
        {
            YiffyMap.mapType = .standard
            satView = false
        }
        else
        {
            YiffyMap.mapType = .satellite
            satView = true
        }
    }
    
    @IBAction func DetailedClose(_ sender: Any)
    {
        DetailedViewPage.isHidden = true
        YiffyMap.isHidden = false
    }
    
    @IBAction func DeleteCity(_ sender: Any) {
        TheAmazingCityDataStructureOMGLikeWow.remove(at: selectedidx)
        tableview.reloadData()
        DetailedViewPage.isHidden = true
        YiffyMap.isHidden = false
        resyncMap()
    }
    
    @IBOutlet weak var FuckingAddThingBox: UIView!
    @IBOutlet weak var CityDescriptionInput: UITextField!
    @IBOutlet weak var CityNameInput: UITextField!
    
    @IBAction func AddButton(_ sender: Any) {
        
        let cs1 = CityStruct(name: CityNameInput.text!, description: CityDescriptionInput.text!, lat: YiffyMap.centerCoordinate.latitude, long: YiffyMap.centerCoordinate.longitude);
        TheAmazingCityDataStructureOMGLikeWow.append(cs1)
        
        resyncMap()
        
        tableview.reloadData()
        FuckingAddThingBox.isHidden = true
        YiffyMap.isHidden = false
        
        CityNameInput.text = ""
        CityDescriptionInput.text = ""
    }
    
    @IBAction func AddButtonThing(_ sender: Any) {
        FuckingAddThingBox.isHidden = false
        YiffyMap.isHidden = true
        resyncMap()
    }
    
    @IBAction func AddCloseButton(_ sender: Any) {
        FuckingAddThingBox.isHidden = true
        YiffyMap.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedidx = indexPath.row
        
        DetailedCityName.text = TheAmazingCityDataStructureOMGLikeWow[selectedidx].name
        DetailedDescriptoin.text = TheAmazingCityDataStructureOMGLikeWow[selectedidx].description

        DetailedViewPage.isHidden = false
        YiffyMap.isHidden = true
        
        print(indexPath.row)
    }

}

