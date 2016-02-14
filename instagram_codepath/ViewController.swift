//
//  ViewController.swift
//  instagram_codepath
//
//  Created by dong liang on 2/10/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

    @IBOutlet weak var mytableview: UITableView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytableview.rowHeight = 320;
        // Do any additional setup after loading the view, typically from a nib.
        let client_id = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(client_id)")
        
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.mytableview.reloadData()
                    }
                }
        });
        task.resume()
        
        
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: UITableViewDataSource {
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    
}