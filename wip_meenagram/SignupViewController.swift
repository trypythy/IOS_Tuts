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
    
    func signup(){
       FIRAuth.auth()?.createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
        
        if error != nil{
            print(error!)
        }else{
            //self.createProfile()
            let homePVC = RootPageViewController()
            self.present(homePVC, animated: true, completion: nil )
        }
       })
    }
    
    func setupProfile(){
        //TODO: Create user profile
    }
    
    func createProfile(_ user: FIRUser){
        
        
    }
    @IBAction func signupButtonAction(_ sender: Any) {
        signup()
        
    }

}
