//
//  SignupViewController.swift
//

import UIKit
import Firebase


class SignupViewController: UIViewController {

    var databaseRef: FIRDatabaseReference!
    

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = FIRDatabase.database().reference()
        
    }
    
    func signup(email:String, password:String){
       FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
        
        if error != nil{
            print(error!)
            return
        }else{
            
            self.createProfile(user!)
            let homePVC = RootPageViewController()
            self.present(homePVC, animated: true, completion: nil )
        }
       })
    }
    
    func createProfile(_ user: FIRUser){
        let delimiter = "@"
        let email = user.email
        let uName = email!.components(separatedBy: delimiter)
    
        let newUser:[String: String] = ["username": uName[0],
                       "email": user.email!]
        
        self.databaseRef.child("profiles").child(user.uid).updateChildValues(newUser) { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
            print("Profile successfully created")
        }

    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        guard let email = emailText.text, let password = passwordText.text else{return}
        signup(email: email, password: password)
        
    }

}
