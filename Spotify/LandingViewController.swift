//
//  LandingViewController.swift
//  SpotifyClone
//
//  Created by Damerla Bhanu Prakash on 23/01/23.
//

import UIKit
import FirebaseAuth

class LandingViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.signOutText, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(signoutTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 20, y: 100, width: view.frame.size.width-40, height: 50)
    }
    
    @objc func signoutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
            print("an error occured")
        }
    }
}
