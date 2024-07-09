//
//  TextFieldInsets.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import UIKit

class TextField: UITextField {
    let inset: CGFloat = 10

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , inset , inset/2)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , inset , inset/2)
    }

    override func placeholderRect(forBounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset/2)
    }
}
