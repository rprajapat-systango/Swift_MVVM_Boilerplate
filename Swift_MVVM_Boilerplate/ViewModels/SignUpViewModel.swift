//
//  SignUpViewModel.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Systango on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

struct SignUpViewModel{
    let fullNameLengthRange = (6,24) // (minimum length, maximum length)
    let fullNameLengthMessage = "Full name length must be in range 6-24 characters."
    let fullNameEmptyMessage = "Please Enter full name"
    let usernameEmptyMessage = "Please Enter Username"
    let usernameErrorMessage = "Entered Username is invalid"
    let passwordEmptyMessage = "Please Enter Password"
    let confirmPasswordEmptyMessage = "Please Enter Confirm Password"
    let passwordLengthRange = (6,14) // (minimum length, maximum length)
    let passwordErrorMessage = "Password length must be in range 6-14 characters."
    let passwordMismatchErrorMessage = "Not matching password and confirm password"
    
    func validateInput(_ fullName:String?,  username:String?, password:String?, confirmPassword:String?, complition: (Bool, String?) -> ()){
        if let fullname = fullName{
            if fullname.count == 0 { // If username is empty
                complition(false, fullNameEmptyMessage)
                return
            }else if(!self.validateTextLength(fullname, range: (6, 24))){
                complition(false, fullNameLengthMessage)
                return
            }
        }else{
            complition(false, fullNameEmptyMessage)
            return
        }
        
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
        
        guard let password = password else {
            complition(false, passwordEmptyMessage)
            return
        }
        
        if password.count == 0 { // If username is empty
            complition(false, passwordEmptyMessage)
            return
        } else if(!validateTextLength(password, range:passwordLengthRange)){ // Checking length of the string
           complition(false, passwordErrorMessage)
            return
        }
        
        if let confirmPassword = confirmPassword{
            if confirmPassword.count == 0 { // If username is empty
                complition(false, confirmPasswordEmptyMessage)
                return
            } else if(!validateTextLength(confirmPassword, range:passwordLengthRange)){ // Checking length of the string
               complition(false, passwordErrorMessage)
                return
            }else if(password != confirmPassword){ // check if pass and confirm pass matching or not
               complition(false, passwordMismatchErrorMessage)
            }
        }else{
            complition(false, confirmPasswordEmptyMessage)
            return
        }
        
        // Validated successfully.
        complition(true, nil)
    }
    
    private func validateTextLength(_ text:String, range:(Int, Int)) -> Bool{
        return (text.count >= range.0) && (text.count <= range.1)
    }
    
    func signUp(_ request:SignUpRequestModel , complition: @escaping (SignUpResponseModel)->()){
        let params = request.getParams()
        print("Signup Input:\(params)")
        var responseModel = SignUpResponseModel()
        responseModel.success = true;
        responseModel.successMessage = "User signed up in successfully"
        responseModel.data = ["Success"]
        complition(responseModel)
    }
}

struct SignUpRequestModel {
    var fullName : String
    var username : String
    var password : String
    var confirmPassword : String
    init(_ fullName:String, username: String, password:String, confirmPassword:String) {
        self.fullName = fullName
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    func getParams()->[String: Any]{
        return ["fullName" : fullName, "username" : username, "password": password, "confirmPassword": confirmPassword]
    }
}

struct SignUpResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data:Any?
}
