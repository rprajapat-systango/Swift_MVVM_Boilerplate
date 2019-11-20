//
//  UIViewControllerExtention.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Systango on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(_ title:String, message:String, actions:[String], complition: @escaping ((String)->())){
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        for title in actions {
            controller.addAction(UIAlertAction.init(title: title, style: .default, handler: { (action) in
                complition(title)
            }))
        }
        self.present(controller, animated: true, completion: nil)
    }
}
