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
		self.textview.becomeFirstResponder()
    }
	
	@IBAction func close() {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func tweet() {
		let dateString = self.getStringForDateToday()
		
        guard let currUser = Auth.auth().currentUser else {
            return
        }
        
		let tweetDict: [String : Any] = [
            "user_id": currUser.uid,
            "tweet_content": self.textview.text!,
            "timestamp": dateString
		]
		
        Database.database().reference().child("/tweets").childByAutoId().setValue(tweetDict)
        self.dismiss(animated: true, completion: nil)
	}
	
	func getStringForDateToday() -> String {
		let dateFormatter = DateFormatter()
		
		dateFormatter.timeZone = TimeZone.autoupdatingCurrent
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"

		return dateFormatter.string(from: Date())
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
