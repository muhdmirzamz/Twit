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

		// email cannot be duplicate
		// password has to be 6 or more characters
		FIRAuth.auth()?.createUser(withEmail: username!, password: password!, completion: { (user, error) in
			
			guard let user = user else {
				DispatchQueue.main.async {
					let alert = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
					let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
					
					alert.addAction(okAction)
					
					self.present(alert, animated: true, completion: nil)
				}

				return
			}
			
			DispatchQueue.main.async {
				let alert = UIAlertController.init(title: "Sign up successful", message: "", preferredStyle: .alert)
				let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
				
				alert.addAction(okAction)
				
				self.present(alert, animated: true, completion: nil)
			}
			
			print("User email: \(user.email!)")
		})
	}
}

