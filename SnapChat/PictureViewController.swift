//
//  PictureViewController.swift
//  SnapChat
//
//  Created by Andrzej Palec on 25/05/2017.
//  Copyright © 2017 Andrzej Palec. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cametaTapped(_ sender: Any) {
    }

    @IBAction func nextTapped(_ sender: Any) {
    }
}
