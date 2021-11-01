//
//  UserAuthenticationVC.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 22/10/21.
//

import UIKit
import GoogleSignIn
import Firebase
import GoogleSignIn
import Algorithms
import FirebaseAuth


class UserAuthenticationVC: UIViewController {
    
    @IBOutlet weak var viewGoogle: UIView!
    @IBOutlet weak var viewPhone: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        googleLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initialSetup() {
        viewGoogle.layer.cornerRadius = 5.0
        viewGoogle.clipsToBounds = true
        
        viewPhone.layer.cornerRadius = 5.0
        viewPhone.clipsToBounds = true
    }
    
    @IBAction func didTapGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    func googleLogin() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    

    
}


extension UserAuthenticationVC: GIDSignInDelegate {
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //Sign in functionality will be handled here
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                
            } else {
                print("Login Successful.")
                print("My Email Address = \(user.profile.email ?? "No Email")\n")
                print("Profile Name = \(user.profile.name ?? "No Name")\n")
                
                let loginAlert = UIAlertController(title: "", message: "Sucessfully Logged in", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default) { obj in
                    let userHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                    self.navigationController?.pushViewController(userHomeVC, animated: true)
                }
                loginAlert.addAction(okButton)
                self.present(loginAlert, animated: true, completion: nil)
                
            }
            
        }
     
    }
        
}




