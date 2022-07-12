//
//  ViewController.swift
//  personInfoApp
//
//  Created by user on 1/22/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MoveTitle: UITextField!
    @IBOutlet weak var Genre: UITextField!
    @IBOutlet weak var TicketSaleDate: UITextField!
    
    @IBOutlet weak var SearchedGenre: UITextField!
    @IBOutlet weak var SearchMovieTitle: UITextField!
    @IBOutlet weak var SearchedTicketSaleDate: UITextField!
    
    var myCurrentPos = 0
    
    class MovieRecord
    {
        var Title:String = ""
        var Genre:String = ""
        var Sale:String  = ""
        
        internal required init(m: String, g:String, s:String)
        {
            self.Title = m
            self.Genre = g
            self.Sale = s
        }
        
        func getTitle() -> String {
            return self.Title
        }
        
        func getGenre() -> String
        {
            return self.Genre
        }
        
        func getSale() -> String
        {
            return self.Sale
        }
        
        func setTitle(t:String)
        {
            self.Title = t
        }
        
        func setGenre(g : String)
        {
            self.Genre = g
        }
        
        func setSale(s : String)
        {
            self.Sale = s
        }
    }
    var TheMovieRecords = [String: MovieRecord]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // calling the search function
    @IBAction func search(_ sender: UIBarButtonItem) {
        // show the alert controller with data input text field
        let alertController = UIAlertController(title: "Search Record", message: "", preferredStyle: .alert)
        
        let serachAction = UIAlertAction(title: "Search", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            var found = false
            if !text.isEmpty
            {
                for (_, movie) in self.TheMovieRecords
                {
                    if (text == movie.getTitle())
                    {
                        self.SearchMovieTitle.text = movie.getTitle()
                        self.SearchedGenre.text = movie.getGenre()
                        self.SearchedTicketSaleDate.text = movie.getSale()
                        found = true
                        break
                    }
                }
            }
            
            if (!found)
            {
                let dm = UIAlertController(title: "Confirm", message: "Record not found!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                dm.addAction(ok)
                self.present(dm, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "enter movie title here"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // adding/updating a new record
    @IBAction func addRec(_ sender: UIBarButtonItem) {
        let LMoveTitle:String = MoveTitle.text ?? "UNK"
        let LGenre:String = Genre.text ?? "UNK"
        let LTicketSaleDate:String = TicketSaleDate.text ?? "UNK"
        
        let mr = MovieRecord(m: LMoveTitle, g: LGenre, s: LTicketSaleDate)
        
        TheMovieRecords[LMoveTitle] = mr
        myCurrentPos = 0
        
        let dm = UIAlertController(title: "Confirm", message: "Record added!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        dm.addAction(ok)
        self.present(dm, animated: true, completion: nil)
        
        self.SearchMovieTitle.text = ""
        self.SearchedGenre.text = ""
        self.SearchedTicketSaleDate.text = ""
    }
    
    @IBAction func UpdateRecord(_ sender: UIBarButtonItem) {
        let LMoveTitle:String = SearchMovieTitle.text ?? "UNK"
        let LGenre:String = SearchedGenre.text ?? "UNK"
        let LTicketSaleDate:String = SearchedTicketSaleDate.text ?? "UNK"
        
        let mr = MovieRecord(m: LMoveTitle, g: LGenre, s: LTicketSaleDate)
        
        TheMovieRecords[LMoveTitle] = mr
        
        let dm = UIAlertController(title: "Confirm", message: "Record updated!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        dm.addAction(ok)
        self.present(dm, animated: true, completion: nil)
        
        self.SearchMovieTitle.text = ""
        self.SearchedGenre.text = ""
        self.SearchedTicketSaleDate.text = ""
    }
    
    // Delete Record
    @IBAction func DeleteMovie(_ sender: UIBarButtonItem)
    {
        let alertController = UIAlertController(title: "Delete Movie by Title", message: "", preferredStyle: .alert)
        
        let serachAction = UIAlertAction(title: "Delete", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            var found = false
            
            if !text.isEmpty {
                
                for (_, movie) in self.TheMovieRecords
                {
                    if (text == movie.getTitle())
                    {
                        self.TheMovieRecords.removeValue(forKey: text)
                        self.myCurrentPos = 0
                        found = true
                        break
                    }
                }
            }
            
            if (!found)
            {
                let dm = UIAlertController(title: "Confirm", message: "Record not found!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                dm.addAction(ok)
                self.present(dm, animated: true, completion: nil)
            }
            else
            {
                let dm = UIAlertController(title: "Confirm", message: "Record Deleted!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
                dm.addAction(ok)
                self.present(dm, animated: true, completion: nil)
                
                self.SearchMovieTitle.text = ""
                self.SearchedGenre.text = ""
                self.SearchedTicketSaleDate.text = ""
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "enter movie here"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func Next(_ sender: Any)
    {
        let totalNumRecords = TheMovieRecords.count
        if (myCurrentPos + 1 < totalNumRecords)
        {
            myCurrentPos = myCurrentPos + 1
        }
        else
        {
            let dm = UIAlertController(title: "Confirm", message: "No more records", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            dm.addAction(ok)
            self.present(dm, animated: true, completion: nil)
        }
        
        if (totalNumRecords > 0)
        {
            let movie = TheMovieRecords[TheMovieRecords.index(TheMovieRecords.startIndex, offsetBy: myCurrentPos)].value
            self.SearchMovieTitle.text = movie.getTitle()
            self.SearchedGenre.text = movie.getGenre()
            self.SearchedTicketSaleDate.text = movie.getSale()
        }
    }
    
    @IBAction func Prev(_ sender: Any)
    {
        if (myCurrentPos - 1 > -1)
        {
            myCurrentPos = myCurrentPos - 1
        }
        else
        {
            let dm = UIAlertController(title: "Confirm", message: "Showing the first Record", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            dm.addAction(ok)
            self.present(dm, animated: true, completion: nil)
        }
            
        let movie = TheMovieRecords[TheMovieRecords.index(TheMovieRecords.startIndex, offsetBy: myCurrentPos)].value
        self.SearchMovieTitle.text = movie.getTitle()
        self.SearchedGenre.text = movie.getGenre()
        self.SearchedTicketSaleDate.text = movie.getSale()
    }
}
 
