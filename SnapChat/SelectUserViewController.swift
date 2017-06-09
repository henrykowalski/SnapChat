//
//  SelectUserViewController.swift
//  SnapChat
//
//  Created by Andrzej Palec on 28/05/2017.
//  Copyright © 2017 Andrzej Palec. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SelectUserViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    
    var descrip = ""
    
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
        
            let user = User()
            
            // puvodni kod co nefunguje v novem xCode
            // user.email = snapshot.value!["email"] as! String
            // puvodni kod co nefunguje v novem xCode:
            // user.uid = snapshot.value!.key!
            
            // v Q&A poradili jak to napsat spravne:
            user.email = (snapshot.value as! NSDictionary) ["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            
            self.tableView.reloadData()
            
        })
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text =  user.email
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let snap = ["from":FIRAuth.auth()!.currentUser!.email!, "description":descrip, "imageURL":imageURL, "uuid":uuid]
        
        FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)
        
    }
    
}
