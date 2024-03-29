//
//  ViewController.swift
//  Twit
//
//  Created by Muhd Mirza on 17/12/18.
//  Copyright © 2018 muhdmirzamz. All rights reserved.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController {
	
	@IBOutlet var usernameTxtField: UITextField!
	@IBOutlet var passwordTxtField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.usernameTxtField.becomeFirstResponder()
	}

	@IBAction func signup() {
		let username = self.usernameTxtField.text
		let password = self.passwordTxtField.text
        
		// email cannot be duplicate
		// password has to be 6 or more characters
        Auth.auth().createUser(withEmail: username!, password: password!) { (dataResult, error) in
            var alertTitle = ""
            var alertMsg = ""
            var okAction: UIAlertAction?
            
            if let dataResult = dataResult {
                alertTitle = "Sign up successful"
                
                
                let profileDict: [String : Any] = [
                        "bio": "",
                        "name": "",
                        "username": ""
                ]
                
                if let currUser = Auth.auth().currentUser {
                    Database.database().reference().child("/profile/\(currUser.uid)").setValue(profileDict)
                    
                    okAction = UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                    })
                }
                
                print("User email: \(dataResult.user.email)")
            } else {
                alertTitle = "Error"
                
                if let error = error {
                    alertMsg = error.localizedDescription
                    
                    okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                    
                    self.usernameTxtField.text = ""
                    self.passwordTxtField.text = ""
                    
                    self.usernameTxtField.becomeFirstResponder()
                }
            }

            DispatchQueue.main.async {
                let alert = UIAlertController.init(title: alertTitle, message: alertMsg, preferredStyle: .alert)
                
                alert.addAction(okAction!)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
	}
	
	@IBAction func close() {
		self.dismiss(animated: true, completion: nil)
	}
}

