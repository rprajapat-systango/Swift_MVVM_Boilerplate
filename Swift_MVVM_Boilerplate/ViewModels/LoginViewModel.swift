//
//  LoginViewModel.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Systango on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

struct LoginViewModel{
    let passwordLengthRange = (6,14) // (minimum length, maximum length)
    let usernameEmptyMessage = "Please Enter Username"
    let passwordEmptyMessage = "Please Enter Password"
    let usernameErrorMessage = "Entered Username is invalid"
    let passwordErrorMessage = "Password length must be in range 6-10 characters."
    
    let loginService = LoginService()
    
    func validateInput(_ username:String?, password:String?, complition: (Bool, String?) -> ()){
        if let username = username{
            if username.count == 0 { // If username is empty
                complition(false, usernameEmptyMessage)
                return
            } else if(!username.isValidEmail()){ // Invalid email
               complition(false, usernameErrorMessage)
                return
            }
        }else{
            complition(false, usernameEmptyMessage)
            return
        }
        
        if let password = password{
            if password.count == 0 { // If username is empty
                complition(false, passwordEmptyMessage)
                return
            } else if(!validateTextLength(password, range: passwordLengthRange)){ // Checking length of the password
               complition(false, passwordErrorMessage)
                return
            }
        }else{
            complition(false, passwordEmptyMessage)
            return
        }
        // Validated successfully.
        complition(true, nil)
    }
    
    private func validateTextLength(_ text:String, range:(Int, Int)) -> Bool{
        return (text.count >= range.0) && (text.count <= range.1)
    }
    
    func login(_ requestModel:LoginRequestModel , complition: @escaping (LoginResponseModel)->()){
        let params = requestModel.getParams()
        print("Input:\(params)")
        var responseModel = LoginResponseModel()
        responseModel.success = true;
        responseModel.successMessage = "User logged in successfully"
        complition(responseModel)
        
        loginService.login(requestModel: requestModel) { (responseModel) in
            print(responseModel.successMessage ?? "no response message")
        }
    }
}

struct LoginRequestModel {
    var username : String
    var password : String
    
    init(username: String, password:String) {
        self.username = username
        self.password = password
    }
    
    func getParams()->[String: Any]{
        return ["username" : username, "password": password]
    }
}

struct LoginResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data:Any?
}
