//
//  CutomTextField.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 11.12.2022.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
       attributedPlaceholder = NSMutableAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        borderStyle = .none
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
