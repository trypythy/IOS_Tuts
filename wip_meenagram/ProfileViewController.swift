//
//  ProfileViewController.swift
//  wip_meenagram
//
//  Created by Ameenah Burhan on 1/30/17.
//  Copyright © 2017 Meena LLC. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var displayNameText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    var databaseRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        databaseRef = FIRDatabase.database().reference()
        
        if let userID = FIRAuth.auth()?.currentUser?.uid{
     
        databaseRef.child("profile").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? "username"
            if let profileImageURL = value?["photo"] as? String{
                let url = URL(string: profileImageURL)
                
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, responose, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage(data: data!)
                    }
                    
                }).resume()
            }
            self.usernameText.text = username
            self.displayNameText.text = username
        }) { (error) in
            print(error.localizedDescription)
        }
        }
    }

    @IBOutlet weak var editProfile: UIButton!
}
