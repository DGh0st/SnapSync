//
//  LoginViewController.swift
//  SnapSync
//
//  Created by DGh0st on 2/23/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }*/
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        usernameField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!, block: { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("you're logged in!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                let errorMessage = error?.localizedDescription ?? "Something went bad"
                let alert = UIAlertController(title: "Sign In", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let alertOk = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                alert.addAction(alertOk)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }

    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock( { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Yay, created user!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                let errorMessage = error?.localizedDescription ?? "Something went bad"
                let alert = UIAlertController(title: "Sign Up", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let alertOk = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                alert.addAction(alertOk)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
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
