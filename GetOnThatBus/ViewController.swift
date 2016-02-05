//
//  ViewController.swift
//  GetOnThatBus
//
//  Created by Yemi Ajibola on 2/2/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    var busStops:[BusStop] = [BusStop]()
    let locationManager = CLLocationManager()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
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
                    self.busStops.append(busStop)
                    self.mapView.addAnnotation(busStop.annotation)
                    //print(busStop.intermodalTransfer)
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
            

            let centerPointAnnotation = MKPointAnnotation()
            centerPointAnnotation.coordinate = CLLocationCoordinate2DMake(41.881832, -87.623177)
            
            self.mapView.addAnnotation(centerPointAnnotation)
            self.mapView.setRegion(MKCoordinateRegionMake(centerPointAnnotation.coordinate, MKCoordinateSpanMake(0.4, 0.4)), animated: true)
            
        
        })
        task.resume()
        
        
        
       
    
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return pin
        
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        print(view.annotation!.title!)
        performSegueWithIdentifier("fromMapView", sender: view.annotation)
       
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        print("Segue identifier: "+segue.identifier!)
        print("Annotation Title: "+(sender?.title)!)
    }


}

