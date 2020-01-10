//
//  LoginService.swift
//  Swift_MVVM_Boilerplate
//
//  Created by SGVVN on 27/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

class LoginService: NSObject {

    func login(requestModel:LoginRequestModel, complition: @escaping (LoginResponseModel)->()){
        guard let serviceURL = URL.init(string: Constants.URLs.baseUrl + Constants.URLs.loginEndPoint) else {
            var response = LoginResponseModel()
            response.errorMessage = Constants.message.invalidUrl
            complition(response)
            return
        }
        let params = requestModel.getParams()
        
        NetworkManager().request(serviceURL, type: .post, params: params,  loadingMessage:"Logging...") { (response) in
            
        }
    }
    
}
