//
//  LoginViewController.swift
//  BanoBuddy
//
//  Created by Chandler Griffin on 3/20/17.
//  Copyright © 2017 BanoBuddy. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: Any) {
        let username = usernameField.text
        let password = passwordField.text
        
        if username?.characters.count == 0 {
            return
        } else if password?.characters.count == 0 {
            return
        }   else    {
            PFUser.logInWithUsername(inBackground: username!, password: password!) { (user: PFUser?, error: Error?) in
                if(user != nil)  {
                    self.emptyFields()
                    self.performSegue(withIdentifier: "mapSegue", sender: self)
                }   else    {
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        let newUser = PFUser()
        
        //User Properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        if newUser.username?.characters.count == 0 {
            return
        } else if newUser.password?.characters.count == 0 {
            return
        }   else    {
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if(success) {
                    self.emptyFields()
                    self.performSegue(withIdentifier: "mapSegue", sender: self)
                }   else    {
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
    
    func emptyFields()  {
        usernameField.text = ""
        passwordField.text = ""
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
