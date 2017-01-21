//
//  SignupViewController.swift
//

import UIKit
import Firebase

class SignupViewController: UIViewController {


    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func signup(){
       FIRAuth.auth()?.createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
        
        if error != nil{
            print(error!)
        }else{
            let homePVC = RootPageViewController()
            self.present(homePVC, animated: true, completion: nil )
        }
       })
    }
    
    func setupProfile(){
        //TODO: Create user profile
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        signup()
        
    }

}
