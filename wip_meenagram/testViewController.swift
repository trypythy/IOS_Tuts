//
//  testViewController.swift
//  wip_meenagram
//
//  Created by Ameenah Burhan on 2/17/17.
//  Copyright © 2017 Meena LLC. All rights reserved.
//


import UIKit
import Firebase
import SDWebImage

class testViewController: UIViewController {

    //
    //  EditProfileViewController.swift
    //  InstaClone
    //
    //  Created by Aurora on 2/8/17.
    //  Copyright © 2017 Aurora. All rights reserved.
    //
    

    class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @IBOutlet weak var profileImageView: UIImageView!
        @IBOutlet weak var usernameText: UITextField!
        @IBOutlet weak var displayNameText: UITextField!
        
        
        var databaseReference: FIRDatabaseReference!
        var storageReference: FIRStorageReference!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            databaseReference = FIRDatabase.database().reference()
            storageReference = FIRStorage.storage().reference()
            if let userId = FIRAuth.auth()?.currentUser?.uid {
                databaseReference.child("profile").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                    let dictionary = snapshot.value as? NSDictionary
                    let userName = dictionary?["username"] as? String
                    if let profileImageURL = dictionary?["photo"] as? String {
                        
                        //                    let url = URL(string: profileImageURL)
                        //                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        //
                        //                        if error != nil {
                        //                            print(error!)
                        //                        }
                        //                        DispatchQueue.main.async {
                        //                            self.profileImageView.image = UIImage(data: data!)
                        //                        }
                        //
                        //                    }).resume()
                        self.profileImageView.sd_setImage(with: URL(string: profileImageURL))
                        
                        
                    }
                    self.usernameText.text = userName
                    self.displayNameText.text = userName
                })
            }
            
        }
        
        
        @IBAction func didSelectImage(_ sender: Any) {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(picker, animated: true, completion: nil)
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            var chosenImage = UIImage()
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            profileImageView.image = chosenImage
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        @IBAction func saveUserInfo(_ sender: Any) {
            updateUserProfile()
            //        print("done")
        }
        
        func updateUserProfile() {
            
            //        ensure user is logged in
            if let userID = FIRAuth.auth()?.currentUser?.uid {
                //        create access point to storage
                let storageItem = storageReference.child("profile_images").child(userID)
                //        get image from photo library
                guard let image = profileImageView.image else {
                    return
                }
                //        upload to firbase storage
                if let newImage = UIImagePNGRepresentation(image) {
                    storageItem.put(newImage, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        storageItem.downloadURL(completion: { (url, error) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            if let photoURL = url?.absoluteString {
                                guard let newUserName = self.usernameText.text else {
                                    return
                                }
                                guard let newDisplayName = self.displayNameText.text else {
                                    return
                                }
                                
                                let newValueForProfile = ["photo": photoURL, "username": newUserName,"displayName": newDisplayName]
                                //        and also to it's database
                                
                                self.databaseReference.child("profile").child(userID).updateChildValues(newValueForProfile, withCompletionBlock: { (error, reference) in
                                    
                                    if error != nil {
                                        return
                                    }
                                    print("Profile Successfully Upadted")
                                    
                                })
                            }
                            
                        })
                    })
                    
                    
                }
                
            }
            
        }
        
        
}
