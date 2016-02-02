//
//  ViewController.swift
//  GetOnThatBus
//
//  Created by Yemi Ajibola on 2/2/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    //var busStops:
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://s3.amazonaws.com/mmios8week/bus.json")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            do
            {
               let dataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                
               let busStopArray = dataDictionary["row"] as! NSArray
                
                for dictionary in busStopArray
                {
                    let busStop = BusStop(dictionary: dictionary as! NSDictionary)
                    self.mapView.addAnnotation(busStop.annotation)
                    
                }
                
            }
            catch let error as NSError
            {
                // Error handling
                print("Json error: \(error.localizedDescription)")
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.mapView.reloadInputViews()
        })
        task.resume()

    }


}

