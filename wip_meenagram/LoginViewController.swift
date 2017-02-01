//
//  LoginViewController.swift
//  wip_meenagram

//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if FIRAuth.auth()?.currentUser?.uid != nil{
            goToHome()
        }
    }

    func login(){
       FIRAuth.auth()?.signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
        if error != nil{
            print(error!)
            return
        }
        
        self.goToHome()
       })
    }
    
    func goToHome(){
       let homePVC = RootPageViewController()
       self.present(homePVC, animated: true, completion: nil)

    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        login()
    }

}
