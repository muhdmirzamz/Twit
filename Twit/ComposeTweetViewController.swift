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
		let tweetDict = ["tweet_content": self.textview.text]
		
		if let currUser = FIRAuth.auth()?.currentUser {
			var ref = FIRDatabase.database().reference().child("/Users/\(currUser.uid)/tweet")
			ref.observeSingleEvent(of: .value) { (snapshot) in
				ref = FIRDatabase.database().reference().child("/Users/\(currUser.uid)/tweet/t\(snapshot.childrenCount + 1)")
				ref.setValue(tweetDict)
				
				self.dismiss(animated: true, completion: nil)
			}
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
