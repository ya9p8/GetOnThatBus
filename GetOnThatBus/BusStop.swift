//
//  BusStop.swift
//  GetOnThatBus
//
//  Created by Yemi Ajibola on 2/2/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import MapKit

class BusStop: NSObject
{
    
    
    var longitude:Double
    var latitude:Double
    var name:String
    var routes:String
    var address:String
    var intermodalTransfer:String
    let annotation = MKPointAnnotation()
    
    init(dictionary:NSDictionary)
    {
        longitude = (dictionary["longitude"] as! NSString).doubleValue
        latitude = (dictionary["latitude"] as! NSString).doubleValue
        name = dictionary["cta_stop_name"]! as! String
        address = dictionary["_address"] as! String
        routes = dictionary["routes"] as! String
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        annotation.title = name
        
        
        if(dictionary["inter_modal"] != nil)
        {
            intermodalTransfer = dictionary["inter_modal"] as! String
        }
        else
        {
            intermodalTransfer = ""
        }
        
    }
    


}
