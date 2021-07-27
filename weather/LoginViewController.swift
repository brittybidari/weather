//
//  ViewController.swift
//  weather
//
//  Created by Britty Bidari on 26/07/2021.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK :- Constants
    private let key = "isLoggedIn"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loggedInState = UserDefaults.standard.bool(forKey: key)
        if loggedInState{
            performSegue(withIdentifier: "Submit", sender: nil)
            return
        }
        initializeViews()
        password.isSecureTextEntry = true
    }
    
    func setCornerRadius(_ view:UIView)
    {
        view.layer.cornerRadius = 5
    }
    func setBorderWidthNone(_ view:UIView){
        view.layer.borderWidth = 0
    }
    
    func initializeViews(){
        setCornerRadius(userName)
        setCornerRadius(password)
        setCornerRadius(submitButton)
        setBorderWidthNone(userName)
        setBorderWidthNone(password)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    if identifier == "Submit"{
        if let userNameText = userName.text, !userNameText.isEmpty{
            if let passwordText = password.text, !passwordText.isEmpty{
                print("Username Text \(userNameText) Password Text \(passwordText)")
                if(passwordText == "britty") && (userNameText == "britty"){
                    
                    UserDefaults.standard.set(true, forKey: key)
                return true
                }
                else{
                    presentAlertWithTitle(title: "Alert", message: "Invalid Credentials.", options: "OK") { _ in
                        print("Dialog Canceled")
                    }
                    return false
                }
                
            }else{
                presentAlertWithTitle(title: "Alert", message: "Password is empty.", options: "OK") { _ in
                    print("Dialog Canceled")
                }
                return false
            }
        }else{
            presentAlertWithTitle(title: "Alert", message: "Username is empty.", options: "OK") { _ in
                print("Dialog Canceled")
            }
            return false
        }
    }
        return false
    }
    
    
    
    
}

extension UIViewController {

    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

