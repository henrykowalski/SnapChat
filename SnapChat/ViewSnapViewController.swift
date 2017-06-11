//
//  ViewSnapViewController.swift
//  SnapChat
//
//  Created by Andrzej Palec on 05/06/2017.
//  Copyright © 2017 Andrzej Palec. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var longerText: UITextView!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

     // nasledujici radek Label jsem nahradil textovym polem ktere zobrazi delsi text
     // label.text = snap.descrip
     
        longerText.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("we deleted the pic")
        }
    }
    
}
