//
//  ComposeTweetViewController.swift
//  Twit
//
//  Created by Muhd Mirza on 29/12/18.
//  Copyright © 2018 muhdmirzamz. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseAuth

class ComposeTweetViewController: UIViewController {

	@IBOutlet var textview: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	@IBAction func close() {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func tweet() {
		if let currUser = FIRAuth.auth()?.currentUser {
			var ref = FIRDatabase.database().reference().child("/Users/\(currUser)/tweet/1").setValue(self.textview.text)
		}
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
