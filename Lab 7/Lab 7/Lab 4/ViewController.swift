//
//  ViewController.swift
//  Lab 4
//
//  Created by Yiff OSX on 2/24/21.
//

import UIKit
import MapKit

struct earthquake
{
    let datetime: String
    let depth: Double
    let lng: Double
    let src: String
    let eqid: String
    let magnitude: Double
    let lat: Double
}

struct earthquakes
{
    let eqs : [earthquake]
}

extension earthquakes: Decodable
{
    private enum Key: String, CodingKey
    {
        case eqs = "earthquakes"
    }
    
    init (from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: Key.self)
        self.eqs = try container.decode([earthquake].self, forKey: .eqs)
    }
}

extension earthquake: Decodable
{
    private enum Key: String, CodingKey
    {
        case datetime = "datetime"
        case depth = "depth"
        case lng = "lng"
        case src = "src"
        case eqid = "eqid"
        case magnitude = "magnitude"
        case lat = "lat"
    }
    
    init (from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: Key.self)
        self.datetime = try container.decode(String.self, forKey: .datetime)
        self.depth = try container.decode(Double.self, forKey: .depth)
        self.lng = try container.decode(Double.self, forKey: .lng)
        self.src = try container.decode(String.self, forKey: .src)
        self.eqid = try container.decode(String.self, forKey: .eqid)
        self.magnitude = try container.decode(Double.self, forKey: .magnitude)
        self.lat = try container.decode(Double.self, forKey: .lat)
    }
}

struct CityStruct
{
    var name : String
    var description : String
    var lat : Double
    var long : Double
}

let tableview : UITableView = {
    let tv = UITableView();
    tv.backgroundColor = UIColor.white;
    tv.translatesAutoresizingMaskIntoConstraints =  false;
    return tv;
}();

var TheAmazingCityDataStructureOMGLikeWow = [CityStruct]()
var lat_north : Double = 0.0
var lat_south : Double = 0.0
var lat_east : Double = 0.0
var lat_west : Double = 0.0

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var idkmenusuchwow: UINavigationBar!
    @IBOutlet weak var SearchBoxUI: UIView!
    @IBOutlet weak var SearchBoxInput: UITextField!
    
    func setLatLong(lat : Double, lon : Double) -> Void
    {
        lat_north = lat + 10.0
        lat_south = lat - 10.0
        lat_east = lon + 10
        lat_west = lon - 10
    }
    
    func getEarthquakes()
    {
        let url_str = "http://api.geonames.org/earthquakesJSON?north=" + String(format: "%0.8f", lat_north) + "&south=" + String(format: "%0.8f", lat_south) + "&east=" + String(format: "%0.8f", lat_east) + "&west=" + String(format: "%0.8f", lat_west) + "&username=tylerfox"
        
        let url = URL(string: url_str)!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request)
        {
            data, response, error  in
            guard let data = data else { return }
        
            do
            {
               let eqs = try JSONDecoder().decode(earthquakes.self, from: data)
                
                var max_eqs = 0
                for eq in eqs.eqs
                {
                    if (max_eqs < 10)
                    
                    {
                        let title : String = eq.datetime + " M" + String(eq.magnitude) + " D" + String(eq.depth) + " SRC " + eq.src
                        let cs : CityStruct = CityStruct(name: title, description: "An Earthquake", lat: eq.lat, long: eq.lng)
                        TheAmazingCityDataStructureOMGLikeWow.append(cs)
                        max_eqs += 1;
                    }
                    else
                    {
                        break
                    }
                }
                
            } catch
            {
                print (error)
            }
            
            DispatchQueue.main.async {
                tableview.reloadData()
            }
        }.resume()
        
    }
    
    @IBAction func SearchButtonPressed(_ sender: Any)
    {
        let geoCoder = CLGeocoder()
        let searchText = SearchBoxInput.text!
        
        geoCoder.geocodeAddressString(searchText) { (placemarks, errors) in
            var placeMark : CLPlacemark!
            placeMark = placemarks?[0]
            let loc : CLLocationCoordinate2D = placeMark.location!.coordinate
            self.setLatLong(lat: loc.latitude, lon: loc.longitude)
            self.getEarthquakes()
        }
    }
    
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
            CityName.widthAnchor.constraint(equalToConstant: 400).isActive = true
            CityName.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
            CityName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
            
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
        return 80
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedidx = indexPath.row
        print(indexPath.row)
    }

}

