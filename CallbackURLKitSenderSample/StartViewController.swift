//
//  ViewController.swift
//  InteractiveSenderTest
//
//  Created by Admin on 07.07.17.
//  Copyright © 2017 LAN-Optic, LLC. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonToMainViewController(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMainViewController", sender: nil)
    }
}

