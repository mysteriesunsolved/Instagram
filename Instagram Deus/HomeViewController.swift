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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
     

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
