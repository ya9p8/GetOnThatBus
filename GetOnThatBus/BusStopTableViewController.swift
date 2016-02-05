//
//  BusStopTableViewController.swift
//  GetOnThatBus
//
//  Created by Yemi Ajibola on 2/3/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit

class BusStopTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var busTableView: UITableView!
    var busStops:[BusStop] = [BusStop]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
                
                    //print(busStop.intermodalTransfer)
                }
                
            }
            catch let error as NSError
            {
                // Error handling
                print("Json error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.busStops.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusStopCell")
        let bus = busStops[indexPath.row]
        
        cell?.textLabel?.text = bus.name
        cell?.detailTextLabel?.text = bus.routes
        
        return cell!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
