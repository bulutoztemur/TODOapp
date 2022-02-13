//
//  UIViewController+Extension.swift
//  GetirTodo
//
//  Created by alaattinbulut on 14.02.2022.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String, message : String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alertController, animated: true, completion: nil)
    }
}
