//
//  PhoneAuthVC.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 28/10/21.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class PhoneAuthVC: UIViewController {
    
    var verification_id: String? = nil
    
    @IBOutlet weak var tf_phone_number: UITextField!
    @IBOutlet weak var tf_otp: UITextField!
    @IBOutlet weak var btnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }
    
    func initialSetup() {
        tf_otp.isHidden = true
        btnOutlet.layer.cornerRadius = 5.0
        btnOutlet.clipsToBounds = true
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        if tf_otp.isHidden {
            
            if !tf_phone_number.text!.isEmpty {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                PhoneAuthProvider.provider().verifyPhoneNumber(tf_phone_number.text!, uiDelegate: nil) { verificationID, error in
                    if (error != nil) {
                        return
                    } else {
                        self.verification_id = verificationID
                        self.tf_otp.isHidden = false
                    }
                }
            } else {
                print("ENTER YOUR MOBILE NUMBER")
            }
            

        } else {
            
            if verification_id != nil {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_id!, verificationCode: tf_otp.text!)
                Auth.auth().signIn(with: credential) { authData, error in
                    if (error != nil) {
                        print(error.debugDescription)
                        
                        
                        let loginAlert = UIAlertController(title: "Logged in Failed", message: "\(error.debugDescription)", preferredStyle: .alert)
                        
                        let okButton = UIAlertAction(title: "OK", style: .default) { obj in
                            
                            
                            let userHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                            self.navigationController?.pushViewController(userHomeVC, animated: true)
                        }
                        loginAlert.addAction(okButton)
                        self.present(loginAlert, animated: true, completion: nil)
                        
                        
                        
                    } else {
                        
                        
                        let loginAlert = UIAlertController(title: "", message: "Sucessfully Logged in", preferredStyle: .alert)
                        
                        let okButton = UIAlertAction(title: "OK", style: .default) { obj in
                            
                            
                            let userHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                            self.navigationController?.pushViewController(userHomeVC, animated: true)
                        }
                        loginAlert.addAction(okButton)
                        self.present(loginAlert, animated: true, completion: nil)

                        
                        
                        print("🌼AUTHENTICATION SUCCESS WITH - " + (authData?.user.phoneNumber! ?? "NO PHONE NUMBER🌼")!)
                    }
                }
            } else {
                print("ERROR IN GETTING VERIFICATION ID")
            }
            
            
        }
        
        

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
