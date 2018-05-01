//
//  ViewController.swift
//  CalPal
//
//  Created by Devin Daher on 4/23/18.
//  Copyright © 2018 Devin Daher. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var invalidTextLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        invalidTextLabel.text = ""
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser{
            self.performSegue(withIdentifier: "toMainScreen", sender: self)
        }
    }


    @IBAction func loginUser(_ sender: Any) {
        guard let username = self.usernameTextField.text else{return}
        guard let email = self.emailTextField.text else{return}
        guard let password = self.passwordTextField.text else{return}
        
        Auth.auth().signIn(withEmail: email, password: password){ user, error in
            if error == nil && user != nil{
                self.dismiss(animated: false, completion: nil)
                self.performSegue(withIdentifier: "toMainScreen", sender: self)
            }else{
                self.invalidTextLabel.text = error!.localizedDescription
                self.invalidTextLabel.textColor = UIColor.red
            }
            
        }
    }
    
    @IBAction func registerUser(_ sender: Any) {
        guard let username = self.emailTextField.text else{return}
        guard let email = self.emailTextField.text else{return}
        guard let password = self.passwordTextField.text else{return}
        
        Auth.auth().createUser(withEmail: email, password: password){ user, error in
            if error == nil && user != nil {
                self.performSegue(withIdentifier: "toMainScreen", sender: self)
                print("Welcome, \(username)")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges{ error in
                    if error == nil{
                        print ("User display name changed!")
//                        self.dismiss(animated: false, completion: nil)
                    }
                }
            }else{
                self.invalidTextLabel.text = error!.localizedDescription
                self.invalidTextLabel.textColor = UIColor.red
//                print("Error creating user: \(error!.localizedDescription)")
            }
        }
    }
}

