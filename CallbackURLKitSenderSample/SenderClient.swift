//
//  SenderClient.swift
//  InteractiveReceiverTest
//
//  Created by Admin on 07.07.17.
//  Copyright © 2017 LAN-Optic, LLC. All rights reserved.
//

import Foundation
import UIKit

class SenderClient: Client {
    
    let receiverName = "callbackurlkitreceiversample"
    let senderName = "callbackurlkitsendersample"
    
    
    public init() {
        super.init(urlScheme: receiverName)
    } 
    
    public func open(text: String, labelReceivedResult: UILabel) {
        do {
            Manager.shared.callbackURLScheme = senderName
            try open(appName: receiverName, action: "sendText",
                     params: ["textFromSender": text],
                     onSuccess: { parameters in
                        labelReceivedResult.text = "SuccessCallback: \(parameters?["successTextFromReceiver"] ?? "no success text was sent")"
                    },
                     onFailure: { error in
                        labelReceivedResult.text = "ErrorCallback: \(error.message)"
                    },
                     onCancel: {
                        labelReceivedResult.text = "CancelCallback"
                    })
        } catch CallbackURLKitError.appWithSchemeNotInstalled(let scheme) {
            labelReceivedResult.text = ("\(scheme) not installed or not implement x-callback-url in current os")

        } catch CallbackURLKitError.callbackURLSchemeNotDefined {
            labelReceivedResult.text = ("current app scheme not defined")
        } catch let e {
            labelReceivedResult.text = ("exception \(e)")
        }
    }
    
    public func open(appName: String, action: String, params: Parameters = [:], onSuccess: SuccessCallback? = nil, onFailure: FailureCallback? = nil, onCancel: CancelCallback? = nil) throws {
                try self.perform(action: action, parameters: params, onSuccess: onSuccess, onFailure: onFailure, onCancel:  onCancel)
        }
}
