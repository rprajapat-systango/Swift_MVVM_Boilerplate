//
//  SignUpViewController.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Systango on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel = SignUpViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView(){
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        signUpButton.configure(5.0, borderColor: UIColor.buttonBorderColor())
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel.validateInput(fullNameTextField.text, username: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text) { (success, errorMessage) in
            if success{
                self.performAPICall()
            }else{
                self.showAlert("Error!", message: errorMessage!, actions: ["Ok"]) { (title) in
                    print("Action title: \(title)")
                }
            }
        }
    }
    
    private func performAPICall(){
        let requestModel = SignUpRequestModel(fullNameTextField.text!, username: emailTextField.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
        viewModel.signUp(requestModel) { (responseModel) in
            if responseModel.success{
                self.showAlert("Success", message: responseModel.successMessage!, actions: ["Done"]) { (title) in
                    print(responseModel.successMessage!)
                }
            }else{
                print(responseModel.errorMessage ?? "No error message")
            }
        }
    }
}

extension SignUpViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == fullNameTextField){
            emailTextField.becomeFirstResponder()
        }else if(textField == emailTextField){
            passwordTextField.becomeFirstResponder()
        }else if(textField == passwordTextField){
            confirmPasswordTextField.becomeFirstResponder()
        }else if (textField == confirmPasswordTextField){
            signUpAction(signUpButton)
        }
        return true;
    }
}
