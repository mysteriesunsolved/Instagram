//
//  PhotoCell.swift
//  Instagram Deus
//
//  Created by Sanaya Sanghvi on 2/29/16.
//  Copyright © 2016 Sanaya Sanghvi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoCell: PFTableViewCell {

    @IBOutlet var profilepictureView: UIImageView!
    
    
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var photoView: PFImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    
    var instagram: PFObject? {
    
    didSet {
    
    let photo = instagram!["media"] as? PFFile
        self.photoView.file = photo
        self.photoView.loadInBackground()
        
        let username = PFUser.currentUser()?.username as! String!
        usernameLabel.text = username
      
        
        let createdAt = instagram?.createdAt
       
        if createdAt != nil {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
       
        
        timestampLabel.text = calculatetime((createdAt?.timeIntervalSinceNow)!)
        } else {
            timestampLabel.hidden = true
        }
        
        let caption = instagram!["caption"] as? String
        if caption != nil {
        captionLabel.text = instagram!["caption"] as? String
        
        } else {
            captionLabel.hidden = true
        }
    
    
    }
}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func calculatetime(timeofpost: NSTimeInterval) -> String{
        
        var rawTime = Int(timeofpost)
        var time: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        if (rawTime <= 60) {
            time = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) {
            time = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) {
            time = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) {
            time = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) {
            
            time = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(time)\(timeChar)"
    }
    
}


