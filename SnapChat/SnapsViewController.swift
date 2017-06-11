//
//  SnapsViewController.swift
//  SnapChat
//
//  Created by Andrzej Palec on 17/05/2017.
//  Copyright © 2017 Andrzej Palec. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
// tady pridavam AV foundation kvuli audiu
import AVFoundation


class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var snaps : [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        

        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let snap = Snap()
            
            
            
            // puvodni kod co nefunguje v novem xCode
            // user.email = snapshot.value!["email"] as! String
            // puvodni kod co nefunguje v novem xCode:
            // user.uid = snapshot.value!.key!
            
            // v Q&A poradili jak to napsat spravne:
            
            snap.imageURL  = (snapshot.value as! NSDictionary) ["imageURL"] as! String
            snap.from  = (snapshot.value as! NSDictionary) ["from"] as! String
            snap.descrip = (snapshot.value as! NSDictionary) ["description"] as! String
            snap.key = snapshot.key
            snap.uuid = (snapshot.value as! NSDictionary) ["uuid"] as! String
            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
            
        })
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            print(snapshot)
            
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            
             self.tableView.reloadData()
        })

        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if snaps.count == 0 {
            return 1
        } else {
            // Rekne to ze mas new snap :)
            
            let mySynthesizer = AVSpeechSynthesizer()
            let myUtterence = AVSpeechUtterance(string: "new snap")
            myUtterence.rate = AVSpeechUtteranceMinimumSpeechRate
            myUtterence.voice = AVSpeechSynthesisVoice(language: "en-au")
            myUtterence.pitchMultiplier = 2 //between 0.5 and 2.0. Default is 1.0.
            mySynthesizer.speak(myUtterence)
            
            // konec audio vlozky
            
        return snaps.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            cell.textLabel?.text = "No snaps baby 😜"
        } else {
        
        
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewsnapsegue", sender: snap)
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewsnapsegue" {
        
        let nextVC = segue.destination as! ViewSnapViewController
        nextVC.snap = sender as! Snap
        }
    }
        
    


    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
