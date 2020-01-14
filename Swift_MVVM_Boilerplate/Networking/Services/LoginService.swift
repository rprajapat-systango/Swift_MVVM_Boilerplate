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
        let params = requestModel.getParams()
        
        NetworkManager().request(Constants.URLs.loginEndPoint, type: .post, params: params,  loadingMessage:"Logging...") { (response) in
                
        }
    }
}
