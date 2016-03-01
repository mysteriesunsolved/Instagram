//
//  UserMedia.swift
//  Instagram Deus
//
//  Created by Sanaya Sanghvi on 2/29/16.
//  Copyright © 2016 Sanaya Sanghvi. All rights reserved.
//

import UIKit
import Parse

let postNotification = "postNotification"

class UserMedia: NSObject {
    
    class func postUserImage(image: UIImage?, caption: String?, completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "UserMedia")
        
        // Add relevant fields to the object
        media["media"] = getPFFileFromImage(image) // PFFile column type
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        media["likesCount"] = 0
        media["commentsCount"] = 0
        media["username"] = PFUser.currentUser()!.username
        
               
        
        NSNotificationCenter.defaultCenter().postNotificationName(postNotification, object: nil)
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
    }
    
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func fetchData(caption: String?, completion: (instagrams: [PFObject]?, error: NSError? ) -> ()){
        var query: PFQuery
        
        if caption != nil {
            let predicate = NSPredicate(format: caption!)
            query = PFQuery(className: "UserMedia", predicate: predicate)
        } else {
            query = PFQuery(className: "UserMedia")
        }
        
        
        
        query.orderByDescending("_created_at")
        query.includeKey("author")
        query.limit = 20
        
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let gotmedia = media {
                print("media recieved")
                completion(instagrams: gotmedia, error: nil)
                
                
            } else {
                print(error?.localizedDescription)
                completion(instagrams: nil, error: error)
            }
        }
        
    }
    
    //isn't working right now

    class func fetchMediaDetails(userMedia: NSDictionary, completion: (instagrams: [PFObject]?, error: NSError? ) -> ()){
        var query: PFQuery
        
        
        query = PFQuery(className: "UserMedia")

        
        query.getObjectInBackgroundWithId("mediaID") {
            (userMedia: PFObject?, error: NSError?) -> Void in
            if error == nil && userMedia != nil {
                print(userMedia)
                print("hi")
            } else {
                print(error)
            }
        }

    }
    
}


