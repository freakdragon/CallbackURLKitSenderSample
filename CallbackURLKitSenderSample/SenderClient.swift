//
//  SenderClient.swift
//  CallbackURLKitSenderSample
/*
The MIT License (MIT)
Copyright © 2017 Eugene Babich (freakdragon). 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
