//
//  UserMedia.swift
//  SnapSync
//
//  Created by DGh0st on 2/29/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit
import Parse

class UserMedia: NSObject {
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "UserMedia")
        
        // Add relevant fields to the object
        media["media"] = getPFFileFromImage(image) // PFFile column type
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        media["createdAt"] = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
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
    
    class func getMedias(completion: (medias: [PFObject]?, error: NSError?) -> ()) {
        // construct PFQuery
        let query = PFQuery(className: "UserMedia")
        query.limit = 20
        query.includeKey("author")
        query.orderByDescending("createdAt")
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (medias: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // do something with the data fetcheD
                completion(medias: medias, error: nil)
            } else {
                // handle error
                completion(medias: nil, error: error)
            }
        }
    }
}
