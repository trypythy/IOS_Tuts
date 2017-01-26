//
//  LoginViewController.swift
//  wip_meenagram

//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        

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
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print(error)
            return
        }
        print("Signed into Google Successfully ")
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("Signed into Firebase successsfully")
        }
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        login()
    }

}
