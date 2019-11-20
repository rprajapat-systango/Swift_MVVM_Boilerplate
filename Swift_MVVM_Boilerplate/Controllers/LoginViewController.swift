//
//  LoginViewController.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Systango on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var viewModel = LoginViewModel()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }
   
    fileprivate func configureView(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.configure(5.0, borderColor: UIColor.buttonBorderColor())
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel.validateInput(emailTextField.text, password: passwordTextField.text) { [weak self] (success, message) in
            if success{
                self?.performAPICall()
            }else{
                self?.showAlert("Error!", message: message!, actions: ["Ok"]) { (actionTitle) in
                    print(actionTitle)
                }
            }
        }
    }
    
    private func performAPICall(){
        let request = LoginRequestModel(username: emailTextField.text!, password: passwordTextField.text!)
        viewModel.login(request) { (responseModel) in
        }
    }
}


extension LoginViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == emailTextField){
            passwordTextField.becomeFirstResponder()
        }else if (textField == passwordTextField){
            self.loginAction(loginButton)
        }
        return true;
    }
}
