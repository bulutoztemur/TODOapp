//
//  UITableViewCell+Extension.swift
//  GetirTodo
//
//  Created by alaattinbulut on 13.02.2022.
//

import UIKit

public extension UITableViewCell {
    static var nibName: String {
        return String(describing: self)
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
