//
//  PokeViewController+Extensions.swift
//  Pokemon Table
//
//  Created by Consultant on 5/6/22.
//

import UIKit

extension UIViewController {
    
    func presentErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

