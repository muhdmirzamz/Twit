//
//  ProfileViewController.swift
//  Twit
//
//  Created by Muhd Mirza on 23/1/19.
//  Copyright © 2019 muhdmirzamz. All rights reserved.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet var tableview: UITableView!
	@IBOutlet var imageView: UIImageView!
	
	var tweetArray = [Tweet]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		self.tableview.dataSource = self
		self.tableview.delegate = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		// download profile image
		// testing image size, might want to change in beta stage?
		if let currUser = FIRAuth.auth()?.currentUser {
			let storageRef = FIRStorage.storage().reference().child("\(currUser.uid)/profile_img.png")
			storageRef.data(withMaxSize: (1 * 1024 * 1024)) { (data, error) in
				if error == nil {
					if let data = data {
						let image = UIImage.init(data: data)
						self.imageView.image = image
					}
				}
			}
		}
		
		
		// download tweets
		self.tweetArray.removeAll()
		
		if let currUser = FIRAuth.auth()?.currentUser {
			
			let ref = FIRDatabase.database().reference().child("/Users/\(currUser.uid)/tweet")
			
			ref.observeSingleEvent(of: .value) { (snapshot) in
				if let dict = snapshot.value as? NSDictionary {
					for i in dict {
						
						var tweet = Tweet()
						
						if let innerDict = i.value as? NSDictionary {
							if let timestamp = innerDict.value(forKey: "timestamp") as? String {
								tweet.timestamp = timestamp
							}
							
							if let tweetContent = innerDict.value(forKey: "tweet_content") as? String {
								tweet.tweetContent = tweetContent
							}
							
							self.tweetArray.append(tweet)
						}
					}
					
					self.tweetArray.sort(by: {$0.timestamp > $1.timestamp})
					
					self.tableview.reloadData()
				}
			}
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.tweetArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		// Configure the cell...
		if self.tweetArray.count > 0 {
			cell.textLabel?.text = self.tweetArray[indexPath.row].tweetContent
		} else {
			cell.textLabel?.text = ""
		}
		
		return cell
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
