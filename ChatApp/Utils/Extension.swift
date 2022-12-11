//
//  Extension.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 11.12.2022.
//

import UIKit

extension UIViewController{
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
}
