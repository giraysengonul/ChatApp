//
//  AppDelegate.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 10.12.2022.
//

import UIKit
import FirebaseCore
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = configureNavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }
    
    private func configureNavigationController(rootViewController: UIViewController)-> UINavigationController{
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        gradient.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.height * 2, height: 64)
        let controller = UINavigationController(rootViewController: rootViewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundImage = self.image(fromLayer: gradient)
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        return controller
    }
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}

