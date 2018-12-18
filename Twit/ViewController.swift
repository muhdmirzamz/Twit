//
//  ViewController.swift
//  Twit
//
//  Created by Muhd Mirza on 17/12/18.
//  Copyright © 2018 muhdmirzamz. All rights reserved.
//

import UIKit

import Firebase

class ViewController: UIViewController {
	
	@IBOutlet var usernameTxtField: UITextField!
	@IBOutlet var passwordTxtField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	@IBAction func signup() {
		let username = self.usernameTxtField.text
		let password = self.passwordTxtField.text
		
		FIRAuth.auth()?.createUser(withEmail: username!, password: password!, completion: { (user, error) in
			if error != nil {
				guard let user = user else {
					return
				}
				
				print("User email: \(user.email!)")
			}
		})
	}
}

