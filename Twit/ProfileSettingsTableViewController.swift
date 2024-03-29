//
//  ProfileSettingsTableViewController.swift
//  Twit
//
//  Created by Muhd Mirza on 25/1/19.
//  Copyright © 2019 muhdmirzamz. All rights reserved.
//

import UIKit

import FirebaseStorage
import FirebaseAuth

protocol ProfileSettingsProtocol {
    func dismissViewController()
    func setBio()
}

class ProfileSettingsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
    var delegate: ProfileSettingsProtocol?
    
	var settingsArray = ["Profile Picture", "Username", "Profile Bio", "Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.settingsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
		cell.textLabel?.text = self.settingsArray[indexPath.row]

        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            case 0:
                let imgPicker = UIImagePickerController()
                imgPicker.allowsEditing = true
                imgPicker.sourceType = .photoLibrary
                imgPicker.delegate = self
                imgPicker.modalPresentationStyle = .fullScreen
                
                self.present(imgPicker, animated: true, completion: nil)
                
                break
            
            case 1:
                guard let profileUsernameViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileUsernameViewController") as? ProfileUsernameViewController else {
                    return
                }
                
                self.navigationController?.pushViewController(profileUsernameViewController, animated: true)
                        
        
                break
                
            case 3:
                do {
                    try Auth.auth().signOut()

                    self.dismiss(animated: true) {
                        self.delegate?.dismissViewController()
                    }
                } catch {
                    print("Error signing out!\n")
                }

                break
                
            default:
                break
        }
        
        
	}
	
	@IBAction func close() {
		self.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let url = info[UIImagePickerController.InfoKey.imageURL] as? URL
		
		if let currUser = Auth.auth().currentUser {
			let storageRef = Storage.storage().reference().child("\(currUser.uid)/profile_img.png")
            
            var title = ""
			do {
				let data = try Data.init(contentsOf: url!)
				
                storageRef.putData(data)

                title = "Image successfully uploaded"
			} catch {
				print("Error")
                
                title = "Image failed to upload"
			}
            
            
            self.dismiss(animated: true) {
                let controller = UIAlertController.init(title: title, message: "", preferredStyle: .alert)
                
                let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                
                controller.addAction(okAction)
                
                self.present(controller, animated: true, completion: nil)
            }
		}
		
		
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		self.dismiss(animated: true, completion: nil)
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
