//
//  ViewController.swift
//  ApplicationSwift-Poizat-Derouet
//
//  Created by warp on 18/10/17.
//  Copyright © 2017 warp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListEventController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    //Class
    let api = Api()

    //Variables
    var events:[Event] = []
    
    //We could have display the pickerview with the event array, but we need to do some processing on data (when picking data on the datepicker for example)
    var tableViewData:[Event] = []
    var pickerViewData:[String] = []
    
    //Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerViewLieuEvent: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
            self.loadingEvents()
    }
    
    @IBAction func onClickMapButton(_ sender: Any) {
        let eventClicked = self.events
        self.performSegue(withIdentifier: "goMapViewController", sender: eventClicked)
    }
    
    func loadingEvents(){
        self.api.getEvents() { responseObject, error in
            // Getting back data (callback)
            self.events = responseObject!
            self.tableViewData = responseObject!
            
            //We can render the view (tableViewData is now fill)
            self.tableView.reloadData()
            
            // Fill and render picker
            self.populatePicker()
            self.pickerViewLieuEvent.reloadAllComponents()
            
            return
        }
    }
    
    func populatePicker(){
        for event in events{
            pickerViewData.append(event.getCommune())
        }
        // Delete duplicates
        pickerViewData = Array(Set(pickerViewData))
        // Move empty string first position
        var indexOfBlankValue:Int = Int()
        for index in 0...pickerViewData.count-1
        {
            if(pickerViewData[index] == "")
            {
                indexOfBlankValue = index
            }
        }
        pickerViewData.remove(at: indexOfBlankValue)
        pickerViewData.insert("", at: 0)
    }

    
    //Table view
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableViewData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = tableViewData[indexPath.row].getTitre()
        return (cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventClicked = tableViewData[indexPath.row]
        self.performSegue(withIdentifier: "goDetailEventController", sender: eventClicked)
    }
    
    //Picker view
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerViewData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // We need to load here the values
        // The filter is empty
        if(pickerViewData[row] == ""){
            tableViewData = events
        }
        //The filter is not empty, so we will filter by commune picked in the pickerView
        else{
            tableViewData.removeAll()
            for event in events
            {
                if(event.getCommune() == pickerViewData[row])
                {
                    tableViewData.append(event)
                }
            }
        }
        tableView.reloadData()
    }
    
    //Pass the event clicked to the detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetailEventController" {
            if let detailEventController = segue.destination as? DetailEventController {
                detailEventController.event = sender as! Event
            }
        }
        // We pass here the whole event array (we need it to display points on map)
        if segue.identifier == "goMapViewController" {
            if let mapViewController = segue.destination as? MapViewController {
                mapViewController.events = sender as! [Event]
            }
        }
    }


}

