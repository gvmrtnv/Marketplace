//
//  HomeTabBarController.swift
//  Influencer
//
//  Created by Gleb Martynov on 16.02.22.
//

import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var shapeLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.layer.cornerRadius = 32
//        tabBar.layer.masksToBounds = true

        tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = true
        self.delegate = self
        
        tabBar.shadowImage = UIImage() // this removes the top line of the tabBar
        tabBar.backgroundImage = UIImage() // this changes the UI backdrop view of tabBar to transparent

    }

//    func generateShadow(for view: UIView) {
//        view.layer.shouldRasterize = true
//        view.layer.rasterizationScale = UIScreen.main.scale
//        view.layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
//        view.layer.shadowOpacity = 1
//        view.layer.shadowRadius = 10
//        view.layer.shadowOffset = .zero
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let vc = HomeViewController()
        let tabOne = UINavigationController(rootViewController: vc)
        let tabOneImage = UIImage(named: "home")
        let tabOneBarItem = UITabBarItem(title: "Home", image: tabOneImage, selectedImage: tabOneImage)

        tabOne.tabBarItem = tabOneBarItem


        let vc2 = InvoiceTabViewController()
        let tabTwo = UINavigationController(rootViewController: vc2)
        let tabTwoImage = UIImage(named: "envelope")
        let tabTwoBarItem = UITabBarItem(title: "Messages", image: tabTwoImage, selectedImage: tabTwoImage)
        tabTwo.tabBarItem = tabTwoBarItem

        let vc3 = InvoiceTabViewController()
        let tab3 = UINavigationController(rootViewController: vc3)
        let tab3Image = UIImage(named: "calculator")
        let tab3BarItem = UITabBarItem(title: "Calculate", image: tab3Image, selectedImage: tab3Image)
        tab3.tabBarItem = tab3BarItem

        let vc4 = InvoiceTabViewController()
        let tab4 = UINavigationController(rootViewController: vc4)
        let tab4Image = UIImage(named: "receipt")
        let tab4BarItem = UITabBarItem(title: "Invoices", image: tab4Image, selectedImage: tab4Image)
        tab4.tabBarItem = tab4BarItem

        let vc5 = ProfileViewController()
        let tab5 = UINavigationController(rootViewController: vc5)
        let tab5Image = UIImage(named: "settings")
        let tab5BarItem = UITabBarItem(title: "Settings", image: tab5Image, selectedImage: tab5Image)
        tab5.tabBarItem = tab5BarItem


        self.viewControllers = [tabOne, tabTwo, tab3, tab4, tab5]
        self.tabBar.tintColor = .black
    }

    override func viewDidLayoutSubviews() {
        addShape()
    }
    
 
    
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(
            roundedRect: tabBar.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 32, height: 0.0)).cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: 32).cgPath
        
        shapeLayer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowOffset = .zero

        // To improve rounded corner and shadow performance tremendously
        shapeLayer.shouldRasterize = true
        shapeLayer.rasterizationScale = UIScreen.main.scale

        if let oldShapeLayer = self.shapeLayer {
            tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
}



