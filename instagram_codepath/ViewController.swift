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

    var myData: [NSDictionary]?
    
    let HeaderViewIdentifier = "TableViewHeaderView"
    let CellIdentifier = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mytableview.dataSource = self
        mytableview.delegate = self
        
//        mytableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        mytableview.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        requestData()

        
        self.mytableview.rowHeight = 320
        // Do any additional setup after loading the view, typically from a nib.
        
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func requestData() {
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
//                            NSLog("response: \(responseDictionary)")
                            self.myData = responseDictionary["data"] as? [NSDictionary]
//                            NSLog("response: \(self.myData)")
//                            NSLog("response: \(self.myData[0])")
                            self.mytableview.reloadData()
                    }
                }
        });
        task.resume()
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! MyTableViewCell
        
        let threadFullData = myData![indexPath.section]
        let imageUrl = threadFullData["images"]!["standard_resolution"]!!["url"] as! String
        cell.threadImageView.setImageWithURL(NSURL(string: imageUrl)!)
        return cell
//        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as UITableViewCell
//        let citiesInSection = data[indexPath.section][1]
//        cell.textLabel!.text = "im good"
//        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let thread = myData {
            return thread.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
//        header.textLabel!.text = "hahahah"
//        return header
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        let threadFullData = myData![section]
        let pro_pic_url = threadFullData["user"]!["profile_picture"] as! String
        let profile_pic = NSURL(string: pro_pic_url)
        let username_label = UILabel(frame: CGRect(x: 50, y: 10, width: 150, height: 30))
        profileView.setImageWithURL(profile_pic!)
        username_label.text = threadFullData["user"]!["username"] as? String
        
        
        headerView.addSubview(profileView)
        headerView.addSubview(username_label)
        // Add a UILabel for the username here
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}