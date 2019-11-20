//
//  ForgotPasswordViewModel.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Systango on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

struct ForgotPasswordViewModel{
    let usernameEmptyMessage = "Please Enter Username"
    let usernameErrorMessage = "Entered Username is invalid"
    
    func validateInput(_ username:String?, complition: (Bool, String?) -> ()){
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
        // Validated successfully.
        complition(true, nil)
    }
    
    func getOtp(_ request:ForgotPasswordRequestModel , complition: @escaping (ForgotPasswordResponseModel)->()){
        print(request.getParams())
        var responseModel = ForgotPasswordResponseModel()
        responseModel.success = true;
        responseModel.successMessage = "One Time Password has been set to your registered email"
        complition(responseModel)
    }
}

struct ForgotPasswordRequestModel {
    var username : String
    init(username: String) {
        self.username = username
    }
    func getParams()->[String: Any]{
        return ["username" : username]
    }
}

struct ForgotPasswordResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data:Any?
}
