//
//  SignupViewController.swift
//  NewsFeed
//
//  Created by Sudhir on 17/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

enum GenderType:String {
    case male = "Male"
    case female = "Female"
    
    var value:String {
        return self.rawValue
    }
}

class SignupViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    
    // iVar
    var gender:GenderType = .male
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Custom Methods
    func setupUI() {
        nameTextField.text = "Sudhir Kumar"
        emailTextField.text = "Sk@email.com"
        passwordTextField.text = "12345678"
        confirmPassword.text = "12345678"
        mobileTextField.text = "9273673954"
    }
    
    // MARK: - IBActions
    @IBAction func signInButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupButtonClicked() {
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
        if (nameTextField.text ?? "").isEmpty || (confirmPassword.text ?? "").isEmpty || (mobileTextField.text ?? "").isEmpty {
            let alertController = UIAlertController().alertWithOk("", message: Constant.AlertMessage.allFieldMandatory)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        signupWithEmail()
    }
    
    @IBAction func genderChoosen() {
        if genderSegmentControl.selectedSegmentIndex == 0 {
            gender = .male
        } else {
            gender = .female
        }
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == mobileTextField {
            IQKeyboardManager.shared.enableAutoToolbar = true
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == mobileTextField {
            IQKeyboardManager.shared.enableAutoToolbar = false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignupViewController {
    // MARK: - WebServices
    func signupWithEmail() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        view.showLoader()
        DataManager.shared.registerWithEmail(emailTextField.text ?? "", password: passwordTextField.text ?? "", name: nameTextField.text ?? "", mobile: mobileTextField.text ?? "", gender: gender.value) { [unowned self] (message, _, error) in
            self.view.hideLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error == nil {
                let controller = UIAlertController().alertWithOk("Success!", message: message ?? "Registration done. Please check your mail to proceed.", handler: { (success) in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(controller, animated: true, completion: nil)
            } else {
                let controller = UIAlertController().alertWithOk("Failed!", message: error?.localizedDescription ?? "Unknown error!")
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}
