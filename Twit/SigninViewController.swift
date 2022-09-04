//
//  SigninViewController.swift
//  Twit
//
//  Created by Muhd Mirza on 23/12/18.
//  Copyright © 2018 muhdmirzamz. All rights reserved.
//

import UIKit

import FirebaseAuth

class SigninViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet var usernameTxtField: UITextField!
	@IBOutlet var passwordTxtField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        self.usernameTxtField.delegate = self
        self.passwordTxtField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
	
	@IBAction func signin() {
		guard let username = self.usernameTxtField.text else {
			return
		}
		
		guard let password = self.passwordTxtField.text else {
			return
		}
		
        
		Auth.auth().signIn(withEmail: username, password: password, completion: { (dataResult, error) in
			var alertTitle = ""
			var alertMsg = ""
			var okAction: UIAlertAction?
			
			if let dataResult = dataResult {
				alertTitle = "Sign in successful"
				
				okAction = UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
					DispatchQueue.main.async {
						let tabBarController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                        
                        tabBarController?.modalPresentationStyle = .fullScreen
						self.present(tabBarController!, animated: true, completion: nil)
					}
				})
				
                print("User email: \(dataResult.user.email)")
			} else {
				alertTitle = "Error"
				
				if let error = error {
					alertMsg = error.localizedDescription
					
					okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
					
					self.usernameTxtField.text = ""
					self.passwordTxtField.text = ""
				}
			}
			
			DispatchQueue.main.async {
				let alert = UIAlertController.init(title: alertTitle, message: alertMsg, preferredStyle: .alert)
				
				
				alert.addAction(okAction!)
				
				self.present(alert, animated: true, completion: nil)
			}
		})
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
