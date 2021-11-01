//
//  SideNavigationBarTableVC.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 27/10/21.
//

import UIKit
import FirebaseAuth

class SideNavigationBarTableVC: UITableViewController {
    
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!


    @IBOutlet weak var tblOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = Auth.auth().currentUser
        lblDisplayName.text = "\(currentUser?.displayName ?? "")"
        lblEmail.text = "\(currentUser?.email ?? "")"
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        if indexPath.row == 1 {
            let alert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let logOutButton = UIAlertAction(title: "Log Out", style: UIAlertAction.Style.destructive) { (navigation) in
                let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desViewController = mainStoryBoard.instantiateViewController(withIdentifier: "UserAuthenticationVC") as! UserAuthenticationVC
                let newFrontViewController = UINavigationController.init(rootViewController:desViewController)
                revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            }
            alert.addAction(cancelButton)
            alert.addAction(logOutButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }

}

