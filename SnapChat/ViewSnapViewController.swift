//
//  ViewSnapViewController.swift
//  SnapChat
//
//  Created by Andrzej Palec on 05/06/2017.
//  Copyright © 2017 Andrzej Palec. All rights reserved.
//

import UIKit

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
    }

    
}
