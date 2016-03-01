//
//  CaptureViewController.swift
//  SnapSync
//
//  Created by DGh0st on 2/29/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tapLabel: UIButton!
    @IBOutlet weak var captionText: UITextField!
    @IBOutlet weak var mediaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let imageTap = UITapGestureRecognizer(target: self, action: Selector("onSelectImage"))
        //mediaImage.addGestureRecognizer(imageTap)
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        if mediaImage.image != nil {
            UserMedia.postUserImage(mediaImage.image, withCaption: captionText.text) { (success: Bool, error: NSError?) -> Void in
                if success {
                    self.performSegueWithIdentifier("postSegue", sender: nil)
                } else {
                    print(error?.localizedDescription);
                }
            }
        }
    }
    
    @IBAction func onSelectImage(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        tapLabel.hidden = false
        mediaImage.image = nil
        captionText.text = ""
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            picker.dismissViewControllerAnimated(true, completion: nil)
            tapLabel.hidden = true
            mediaImage.image = resize(editedImage, newSize: CGSize(width: 300, height:300))
            tapLabel.hidden = true
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
