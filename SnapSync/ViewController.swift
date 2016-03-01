//
//  ViewController.swift
//  SnapSync
//
//  Created by DGh0st on 2/23/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var medias: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "didRefresh:", forControlEvents: .ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        didRefresh(refreshControl)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func didRefresh(refreshControl: UIRefreshControl) {
        UserMedia.getMedias({ (medias, error) -> () in
            if error == nil {
                self.medias = medias
                self.tableView.reloadData()
            }
        })
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        if medias != nil {
            return medias!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MediaCell", forIndexPath: indexPath) as! MediaCell
        
        cell.media = medias![indexPath.row]
        let image = cell.media.objectForKey("media")
        image!.getDataInBackgroundWithBlock({(response: NSData?, error: NSError?) -> Void in
            if response != nil {
                cell.mediaImage.image = UIImage(data: response!)
            }
        })
        
        return cell
    }

    @IBAction func onSignOut(sender: AnyObject) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log off?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
            PFUser.logOutInBackground()
            NSNotificationCenter.defaultCenter().postNotificationName("userDidLogoutNotification", object: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

