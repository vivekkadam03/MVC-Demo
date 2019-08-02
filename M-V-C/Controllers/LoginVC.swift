//
//  LoginVC.swift
//  M-V-C
//
//  Created by Axat MAC Mini 1 on 19/07/19.
//  Copyright © 2019 Axat MAC Mini 1. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var activity = UIActivityIndicatorView()
    var login_view = LoginView()
    var result = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        login_view.frame = self.view.bounds
        self.view.addSubview(login_view)
        login_view.delegate = self
        // Do any additional setup after loading the view.
        self.activity = UIActivityIndicatorView(style: .whiteLarge)
        self.activity.frame = CGRect(x: (UIScreen.main.bounds.size.width/2)-60, y: (UIScreen.main.bounds.size.height/2)-40, width: 120.0, height: 80.0)
        self.activity.backgroundColor = UIColor.black
        self.activity.layer.cornerRadius = 20.0
        self.activity.layer.opacity = 0.7
        self.view.addSubview(self.activity)
        
        self.result = "Initial Phase"
        self.login_view.Reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Login"
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func ShowAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
extension LoginVC : LoginDelegate {
    func GetData() -> String {
        return self.result
    }
    
    func UserDetails(email: String, passward: String) {
        self.activity.startAnimating()
        NetworkCall.Login(forUser: User(Email: email, Password: passward)) { (value, err, u) in
            if value {
                print("\(u!.Name) \(u!.Email) \(u!.id) \(u!.mobile) \(u!.token)")
            } else {
                print("Error \(err!)")
            }
            self.activity.stopAnimating()
        }
    }
    
    func NotFound(errorType: LoginError) {
        if errorType == .EmailNotFound {
            self.ShowAlert(title: "Email", msg: "Please enter email")
            
            self.result = "Email Error"
            self.login_view.Reload()
            
        } else if errorType == .PasswordNotFound {
            self.ShowAlert(title: "Password", msg: "Please enter password")
            
            self.result = "Email Error"
            self.login_view.Reload()
        }
    }
}
