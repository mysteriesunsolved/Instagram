//
//  CreatePhotoViewController.swift
//  Instagram Deus
//
//  Created by Sanaya Sanghvi on 2/29/16.
//  Copyright © 2016 Sanaya Sanghvi. All rights reserved.
//

import UIKit
import Parse

class CreatePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    
    
    @IBOutlet var postingimageView: UIImageView!
    @IBOutlet var captionText: UITextView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.captionText.delegate = self
       
        captionText.layer.borderWidth = 1
        captionText.layer.cornerRadius = 8
        captionText.layer.borderColor = UIColor .blueColor().CGColor
        self.postingimageView.image = UIImage(named: "placeholder.png")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.image = resize(editedImage, newSize: CGSizeMake(750, 750))
        self.postingimageView.image = self.image
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    
       
    @IBAction func pickFromCamera(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    @IBAction func postImage(sender: AnyObject) {
        
        UserMedia.postUserImage(image, caption: captionText.text,completion: nil)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
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
