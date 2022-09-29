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

class ProfileViewController: UIViewController, ProfileSettingsProtocol {
    
//    @IBOutlet var bio: UILabel!
    
//	@IBOutlet var tableview: UITableView!
	@IBOutlet var imageView: UIImageView!
	
	var tweetArray = [Tweet]()
    var profileImg: UIImage?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
//		self.tableview.dataSource = self
//		self.tableview.delegate = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		if let currUser = Auth.auth().currentUser {
            let storageRef = Storage.storage().reference().child("\(currUser.uid)/profile_img.png")
            storageRef.getData(maxSize: ((1 * 1024 * 1024))) { (data, error) in
                if error == nil {
                    if let data = data {
                        self.profileImg = UIImage.init(data: data)
                        self.imageView.image = self.profileImg

//                        DispatchQueue.main.async {
//                            self.tableview.reloadData()
//                        }
                    }
                }
            }
            
            self.tweetArray.removeAll()
			
			let ref = Database.database().reference().child("/Users/\(currUser.uid)/tweet")
			
			ref.observeSingleEvent(of: .value) { (snapshot) in
				if let dict = snapshot.value as? NSDictionary {
					for i in dict {
						
						let tweet = Tweet()
						
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
					
//					DispatchQueue.main.async {
//                        self.tableview.reloadData()
//                    }
				}
			}
		}
	}
	
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return self.tweetArray.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TweetTableViewCell else {
//            print("Error on loading cell")
//
//            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        }
//
//        // Configure the cell...
//        if self.tweetArray.count > 0 {
//            cell.textLabel?.text = self.tweetArray[indexPath.row].tweetContent
//            cell.profileImageView.image = self.profileImg
//        } else {
//            cell.textLabel?.text = ""
//        }
//
//		return cell
//	}
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
	
    func setBio() {
        
    }
    
/*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
         //Pass the selected object to the new view controller.
        
        if segue.identifier == "ProfileSettingsTableViewControllerSegue" {
            let navController = segue.destination as? UINavigationController
            let profileSettingsTableViewController = navController?.viewControllers.first as? ProfileSettingsTableViewController
            
            profileSettingsTableViewController?.delegate = self
        }
    }
    

}
