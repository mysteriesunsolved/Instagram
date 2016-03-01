//
//  HomeViewController.swift
//  Instagram Deus
//
//  Created by Sanaya Sanghvi on 2/28/16.
//  Copyright © 2016 Sanaya Sanghvi. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    var instagrams = [PFObject]?()
  
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
     
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl.tintColor = UIColor .blueColor()
        tableView.addSubview(refreshControl)
     

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UserMedia.fetchData(nil, completion: {(instagrams, error) -> () in
            print("I'm here")
            self.instagrams = instagrams
            self.tableView.reloadData()
            print(instagrams)
        })
        self.tableView.reloadData()
        print("check3")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
     
        print(PFUser.currentUser())
        
        performSegueWithIdentifier("logout", sender: self)
        }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if instagrams != nil {
            return instagrams!.count
        } else {
            return 0
        }
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        let instagram = instagrams![indexPath.row]
        
        cell.instagram = instagram
        
        return cell
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
        UserMedia.fetchData(nil, completion: {(instagrams, error) -> () in
            
            self.instagrams = instagrams
            
            self.tableView.reloadData()
        })

       }
    
   
    
    @IBAction func toCamera(sender: AnyObject) {
        
        performSegueWithIdentifier("toCamera", sender: self)
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
