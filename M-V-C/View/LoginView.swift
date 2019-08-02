//
//  LoginView.swift
//  M-V-C
//
//  Created by Axat MAC Mini 1 on 19/07/19.
//  Copyright © 2019 Axat MAC Mini 1. All rights reserved.
//

import UIKit

enum LoginError {
    case EmailNotFound
    case PasswordNotFound
}

protocol LoginDelegate: class {
    func UserDetails(email:String, passward:String)
    func NotFound(errorType: LoginError)
    func GetData() -> String
}

class LoginView: UIView {

    @IBOutlet var loginView: UIView!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    var delegate : LoginDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CommonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonInit()
    }
    
    public func CommonInit() {
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        addSubview(loginView)
        loginView.frame = self.bounds
        loginView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func Reload() {
        if let data = delegate?.GetData() {
            print("The string received: \(data)")
        } else {
            print("No data")
        }
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        if EmailTxt.text?.count == 0 {
            delegate?.NotFound(errorType: .EmailNotFound)
        } else if PasswordTxt.text?.count == 0 {
            delegate?.NotFound(errorType: .PasswordNotFound)
        } else {
            delegate?.UserDetails(email: self.EmailTxt.text!, passward: self.PasswordTxt.text!)
        }
    }
    
}
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
