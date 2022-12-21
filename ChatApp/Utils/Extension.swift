//
//  Extension.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 11.12.2022.
//

import UIKit
import JGProgressHUD
extension UIViewController{
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    func showProgressHud(showProgress: Bool){
        let progressHud = JGProgressHUD(style: .dark)
        progressHud.textLabel.text = "Plase Wait"
        showProgress ? progressHud.show(in: view):  progressHud.dismiss()
    }
    
    func add(_ child: UIViewController){
        addChild(child)
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(){
        willMove(toParent: self)
        self.view.removeFromSuperview()
        removeFromParent()
    }
    
}
extension UIView{
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
