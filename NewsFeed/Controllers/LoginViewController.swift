//
//  LoginViewController.swift
//  NewsFeed
//
//  Created by Sudhir on 17/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "hari2@spotflock.com"
        passwordTextField.text = "akjshdlaks"
    }
    
    // MARK: - Custom Methods
    func setupUI() {
        
    }
    
    // MARK: - IBActions
    @IBAction func signInButtonClicked() {
        if !(emailTextField.text ?? "").isValidEmail() {
            let alertController = UIAlertController().alertWithOk("", message: Constant.AlertMessage.invalidEmail)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if !(passwordTextField.text ?? "").isValidPassword() {
            let alertController = UIAlertController().alertWithOk("", message: Constant.AlertMessage.invalidPassword)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        loginWithEmail()
    }
    
    @IBAction func signupButtonClicked() {
        let signupController = UIStoryboard.navigateToSignup()
        navigationController?.pushViewController(signupController, animated: true)
    }
    
    @IBAction func forgotPasswordButtonClicked() {
        print("Not implemented yet.")
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController {
    // MARK: - WebServices
    func loginWithEmail() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        view.showLoader()
        DataManager.shared.loginWithEmail(emailTextField.text?.trimmed() ?? "", password: passwordTextField.text?.trimmed() ?? "") { [unowned self] _, _, error in
            self.view.hideLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error == nil {
                let newsFeedController = UIStoryboard.navigateToNewsFeed()
                self.navigationController?.pushViewController(newsFeedController, animated: true)
            } else {
                let controller = UIAlertController().alertWithOk("Failed!", message: error?.localizedDescription ?? "Unknown error!")
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}
