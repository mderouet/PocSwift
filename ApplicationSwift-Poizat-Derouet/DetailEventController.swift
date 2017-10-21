//
//  ViewController.swift
//  ApplicationSwift-Poizat-Derouet
//
//  Created by warp on 18/10/17.
//  Copyright © 2017 warp. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailEventController: UIViewController{
    
    //Event reception(prepare for segue)
    public var event:Event = Event()

    // Outlets
    
    @IBOutlet weak var labelTitre: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var textViewLocalisation: UITextView!
    @IBOutlet weak var imageViewEvent: UIImageView!
    @IBOutlet weak var buttonMap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Preparing text information of event
        loadEventOnScreen()
        loadImageEvent()
        
        //Disable the map function if the current event has no X/Y coordinates
        if Double(event.getX()) == nil && Double(event.getY()) == nil{
            buttonMap.isEnabled = false
        }
    }
    
    
    @IBAction func onClickMapButton(_ sender: Any) {
        let eventClicked = self.event
        self.performSegue(withIdentifier: "goMapViewController", sender: eventClicked)
    }

    
    func loadEventOnScreen(){
        
        labelTitre.text = event.getTitre()
        textViewDescription.text = event.getDescription()
        //Localisation
        
        textViewLocalisation.text = ""
        if(event.getCommune() != ""){
            textViewLocalisation.text = "Commune : " + "\n" + event.getCommune()
        }
        if(event.getLieu() != ""){
            textViewLocalisation.text = textViewLocalisation.text + "\n" + "Lieu : " + "\n" + event.getLieu()
        }
        if(event.getAcces() != ""){
            textViewLocalisation.text = textViewLocalisation.text + "\n" + "Acces : " + "\n" + event.getAcces()
        }
    }
    
    func loadImageEvent(){
        Alamofire.request(event.getImageUrl()).responseImage { response in
            if let image = response.result.value {
                self.imageViewEvent.image = image
            }
        }
    }

    
    //Pass the event clicked to the detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMapViewController" {
            if let mapViewController = segue.destination as? MapViewController {
                mapViewController.eventDetail = sender as! Event
            }
        }
    }
    
}

