//
//  AlamoHttpHandlerService.swift
//  ApplicationSwift-Poizat-Derouet
//
//  Created by warp on 18/10/17.
//  Copyright © 2017 warp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


public class Api
{
    //Urls
    let urlJsonEvent:String = "http://www.montpellier3m.fr/opendata-export-agenda-json"
    
    //Variables
    var events:[Event] = []
    
    //Class
    let utils:Utils = Utils()

    func getEvents(completionHandler: @escaping ([Event]?, Error?) -> ()) {
        eventRequest("orders", completionHandler: completionHandler)
    }
    
    
    //MUST STAY PRIVATE (We should use only CompletionHandlers to handle requests)
    private func eventRequest(_ section: String, completionHandler: @escaping ([Event]?, Error?) -> ()) {
        Alamofire.request(urlJsonEvent).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                for currentAgenda in json["agenda"].arrayValue {
                    let currentEvent:Event = Event()
                    currentEvent.setId(id: currentAgenda["event"]["nid"].string!)
                    currentEvent.setTitre(titre: currentAgenda["event"]["titre"].string!)
                    currentEvent.setImageUrl(imageUrl: currentAgenda["event"]["field_vignette"]["src"].string!)
                    currentEvent.setImageAlt(imageAlt: currentAgenda["event"]["field_vignette"]["alt"].string!)
                    currentEvent.setDate(date: currentAgenda["event"]["field_date"].string!)
                    currentEvent.setDescription(description: self.utils.stripHTML(fromString:currentAgenda["event"]["description"].string!))
                    
                    //Check for nil (others values seems to be not nullable)
                    if currentAgenda["event"]["field_communes"].string != nil{
                        currentEvent.setCommune(commune: (currentAgenda["event"]["field_communes"].string)!)
                    }
                    if currentAgenda["event"]["field_lieu"].string != nil{
                        currentEvent.setLieu(lieu:currentAgenda["event"]["field_lieu"].string!)
                    }
                    if currentAgenda["event"]["field_lieu"].string != nil{
                        currentEvent.setLieu(lieu:currentAgenda["event"]["field_lieu"].string!)
                    }
                    if currentAgenda["event"]["field_acces"].string != nil{
                        currentEvent.setAcces(acces:currentAgenda["event"]["field_acces"].string!)
                    }
                    if currentAgenda["event"]["thematique"].string != nil{
                        currentEvent.setThematique(thematique:currentAgenda["event"]["thematique"].string!)
                    }
                    if currentAgenda["event"]["x"].string != nil{
                        currentEvent.setX(x:currentAgenda["event"]["x"].string!)
                    }
                    if currentAgenda["event"]["y"].string != nil{
                        currentEvent.setY(y:currentAgenda["event"]["y"].string!)
                    }
                    currentEvent.setUrlSite(urlSite: currentAgenda["event"]["url"].string!)
                    
                    //Appending our event here
                    self.events.append(currentEvent)
                }
                //But we want to send the whole array so the handler will be call here
                completionHandler(self.events, nil)
            }
        }
    }

}


