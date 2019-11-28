//
//  NetworkManager.swift
//  Swift_MVVM_Boilerplate
//
//  Created by SGVVN on 27/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

enum RequestType:String {
    case get
    case post
}

class NetworkManager: NSObject {
    func request(_ serviceUrl:URL, type:RequestType = .get, params:[String:Any]? = [:], complition: @escaping (Any)->()){
        var request = URLRequest(url: serviceUrl)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        request.httpMethod = type.rawValue.uppercased()
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        // If request type is post, then paramaters must be set in the request
        if let params = params{
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                //
                complition(error)
                return;
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                    complition(json)
                } catch {
                    complition(error)
                }
            }
        }
        // do whatever you need with the task e.g. run
        task.resume()
    }
}
