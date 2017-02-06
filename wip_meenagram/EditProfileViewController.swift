//
//  EditProfileViewController.swift
//  wip_meenagram
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var displayNameText: UITextField!
    @IBOutlet weak var bioText: UITextField!
    
    
    var databaseRef: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        
        databaseRef = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference()
        
        loadProfileData()
        
    }
    @IBAction func changePhotoButton(_ sender: Any) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(picker, animated: true, completion: nil)
        
    }
    @IBAction func saveAllProfileChanges(_ sender: Any) {
        updateProfile()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelProfileChanges(_ sender: Any) {
    }
 
    
    func loadProfileData(){
        //create database reference
        databaseRef = FIRDatabase.database().reference()
        //if the user is logged in get the profile data
        if let userID = FIRAuth.auth()?.currentUser?.uid{
            databaseRef.child("profile").child(userID).observe(.value, with: { (snapshot) in
                //create a diction of users profile data
                let values = snapshot.value as? NSDictionary
                //if there is a url image stored in photo
                if let profileImageURL = values?["photo"] as? String{
                    //using sd_setImage load photo
                    self.profileImageView.sd_setImage(with: URL(string: profileImageURL))
                }
                self.usernameText.clearsOnBeginEditing = true
                self.usernameText.text = values?["username"] as? String

                self.displayNameText.clearsOnBeginEditing = true
                self.displayNameText.text = values?["display"] as? String
                
                self.bioText.clearsOnBeginEditing = true
                self.bioText.text = values?["bio"] as? String
            })
            
        }
    }
 
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            
            profileImageView.image = selectedImage
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
            profileImageView.clipsToBounds = true
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker did cancel")
        dismiss(animated: true, completion: nil)
        
    }
    func updateProfile(){
        if let userID = FIRAuth.auth()?.currentUser?.uid{
            //save photo in storage
            
            let storageItem = storageRef.child("profile_images").child(userID)
            
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!)
            {
                storageItem .put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    storageItem .downloadURL(completion: { (url, error) in
                        if error != nil{
                            print("error with url")
                            return
                        }
                        if let urlText = url?.absoluteString{
                            guard let newUserName = self.usernameText.text else{return}
                            guard let newDisplayName = self.displayNameText.text else{return}
                            guard let newBioText = self.bioText.text else {return}
                            
                            let newValuesForProfile =
                                [ "photo": urlText, "username": newUserName,
                                  "display": newDisplayName, "bio": newBioText]
                            self.databaseRef.child("profile").child(userID).updateChildValues(newValuesForProfile, withCompletionBlock: { (error, ref) in
                                if error != nil{
                                    print("Error loading ", error!)
                                    return
                                }else{
                                    
                                    
                                }
                            })
                        }
                        
                    })
                    
                })
                
            }
        
            //save username text to database
            //save display name text to database
            //save bio to database
            //update users profile in the database
        }
    }
    
    func maxTextLength(){
        
    }
}

