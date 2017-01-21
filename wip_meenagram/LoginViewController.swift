//
//  LoginViewController.swift
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil{
            //goToHomePage()
            do{
                try FIRAuth.auth()?.signOut()
            }catch let signOutError as NSError{
                print(signOutError)
            }
        
        }
    }
    func login(){
        FIRAuth.auth()?.signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
            if error != nil{
                print(error!)
                return
            }
            self.goToHomePage()
        })
    }
    func goToHomePage(){
        let homePVC = RootPageViewController()
        self.present(homePVC, animated: true, completion: nil)
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        if emailText?.text !=  nil && passwordText?.text != nil{
            login()
        }
        
    }
}
