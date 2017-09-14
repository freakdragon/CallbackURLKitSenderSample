//
//  ViewController.swift
//  InteractiveSenderTest
//
//  Created by Admin on 07.07.17.
//  Copyright © 2017 LAN-Optic, LLC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var textfieldSendText: UITextField!
    @IBOutlet weak var labelReceivedResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldSendText.layer.borderWidth = 1.0
        textfieldSendText.layer.cornerRadius = 3.0
    }

    @IBAction func buttonSendTextAction(_ sender: UIButton) {
        let senderClient = SenderClient()
        senderClient.open(text: textfieldSendText.text ?? "", labelReceivedResult: labelReceivedResult)
    }
}

