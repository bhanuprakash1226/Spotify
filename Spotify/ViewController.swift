//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Damerla Bhanu Prakash on 23/01/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Constants.loginText
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = Constants.emailFieldPlaceHolder
        emailTextField.setupTextField(emailTextField)
        return emailTextField
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = Constants.passwordFieldPlaceHolder
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setupTextField(passwordTextField)
        return passwordTextField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.continueText, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(button)
        button.addTarget(self, action: #selector(tapOnContinueButton), for: .touchUpInside)
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            let landingVC = LandingViewController()
            self.navigationController?.pushViewController(landingVC, animated: false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
        emailTextField.frame = CGRect(x: 20, y: Int(label.frame.origin.y+label.frame.size.height)+15, width: Int(view.frame.size.width)-40, height: 50)
        passwordTextField.frame = CGRect(x: 20, y: Int(emailTextField.frame.origin.y+emailTextField.frame.size.height)+15, width: Int(view.frame.size.width)-40, height: 50)
        button.frame = CGRect(x: 20, y: Int(passwordTextField.frame.origin.y+passwordTextField.frame.size.height)+20, width: Int(view.frame.size.width)-40, height: 40)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    @objc func tapOnContinueButton() {
        guard let email = emailTextField.text , !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            print("missing Fields data")
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                // error is present, means dont have an account.
                self.createAnAccount(email,password)
                return
            }
            print("you are signed in ")
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
            let landingVC = LandingViewController()
            self.navigationController?.pushViewController(landingVC, animated: false)
        }
    }
    
    func createAnAccount(_ email: String,_ password: String) {
        let alert = UIAlertController(title: Constants.createAccountText, message: Constants.alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.continueText, style: .default,handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    print("Account creation failed.")
                    return
                }
            }
        }))
        alert.addAction(UIAlertAction(title: Constants.cancelText, style: .cancel, handler: { _ in
        }))
        present(alert, animated: true)
    }
}


