//
//  FeedTableViewController.swift
//  Twit
//
//  Created by Muhd Mirza on 4/1/19.
//  Copyright © 2019 muhdmirzamz. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class FeedTableViewController: UITableViewController {
    
	var tweetArray = [Tweet]()
    var profileImg: UIImage?
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		if let currUser = Auth.auth().currentUser {
//            let storageRef = Storage.storage().reference().child("\(currUser.uid)/profile_img.png")
//            storageRef.getData(maxSize: ((1 * 1024 * 1024))) { (data, error) in
//                if error == nil {
//                    if let data = data {
//                        self.profileImg = UIImage.init(data: data)
//
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }
//                }
//            }
            

            // download tweets
            self.tweetArray.removeAll()
            
			let ref = Database.database().reference().child("/tweets")

			ref.observeSingleEvent(of: .value) { (snapshot) in
                
//                print("json response: \(snapshot)")
                let jsonResponse = snapshot
                
				if let tweetsDictionary = jsonResponse.value as? NSDictionary {
					for individualTweetDict in tweetsDictionary {

//                        print("Individual tweet dict: \(individualTweetDict)")
                        
						let tweet = Tweet()

						if let tweetObject = individualTweetDict.value as? NSDictionary {
//                            print("Inner Dict: \(innerDict)")
                            
							if let timestamp = tweetObject.value(forKey: "timestamp") as? String {
								tweet.timestamp = timestamp
							}

							if let tweetContent = tweetObject.value(forKey: "tweet_content") as? String {
								tweet.tweetContent = tweetContent
							}

							self.tweetArray.append(tweet)
						}
					}
					
					self.tweetArray.sort(by: {$0.timestamp > $1.timestamp})
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
				}
			}
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tweetArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TweetTableViewCell else {
            print("Error on loading cell")
            
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }

        // Configure the cell...
		if self.tweetArray.count > 0 {
			cell.textLabel?.text = self.tweetArray[indexPath.row].tweetContent
            cell.profileImageView.image = self.profileImg
		} else {
			cell.textLabel?.text = ""
		}
		

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
