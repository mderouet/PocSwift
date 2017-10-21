//
//  Event.swift
//  ApplicationSwift-Poizat-Derouet
//
//  Created by warp on 18/10/17.
//  Copyright © 2017 warp. All rights reserved.
//

import Foundation


public class Event
{
    
    private var id:String = String()
    private var titre:String = String()
    private var imageUrl:String = String()
    private var imageAlt:String = String()
    private var date:String = String()
    private var description:String = String()
    private var commune:String = String()
    private var lieu:String = String()
    private var acces:String = String()
    private var thematique:String = String()
    private var x:String = String()
    private var y:String = String()
    private var urlSite:String = String()
    
    //Constructor, no init necessary for this POC
    
    
    //Getters
    func getId()->String
    {
        return self.id
    }
    func getTitre()->String
    {
        return self.titre
    }
    func getImageUrl()->String
    {
        return self.imageUrl
    }
    func getImageAlt()->String
    {
        return self.imageAlt
    }
    func getDate()->String
    {
        return self.date
    }
    func getDescription()->String
    {
        return self.description
    }
    func getCommune()->String
    {
        return self.commune
    }
    func getLieu()->String
    {
        return self.lieu
    }
    func getAcces()->String
    {
        return self.acces
    }
    func getThematique()->String
    {
        return self.thematique
    }
    func getX()->String
    {
        return self.x
    }
    func getY()->String
    {
        return self.y
    }
    func getUrlSite()->String
    {
        return self.urlSite
    }
    
    
    //Setters
    func setId(id:String)
    {
        self.id = id
    }
    func setTitre(titre:String)
    {
        self.titre = titre
    }
    func setImageUrl(imageUrl:String)
    {
        self.imageUrl = imageUrl
    }
    func setImageAlt(imageAlt:String)
    {
        self.imageAlt = imageAlt
    }
    func setDate(date:String)
    {
        self.date = date
    }
    func setDescription(description:String)
    {
        self.description = description
    }
    func setCommune(commune:String)
    {
        self.commune = commune
    }
    func setLieu(lieu:String)
    {
        self.lieu = lieu
    }
    func setAcces(acces:String)
    {
        self.acces = acces
    }
    func setThematique(thematique:String)
    {
        self.thematique = thematique
    }
    func setX(x:String)
    {
        self.x = x
    }
    func setY(y:String)
    {
        self.y = y
    }
    func setUrlSite(urlSite:String)
    {
        self.urlSite = urlSite
    }
    
    
}
