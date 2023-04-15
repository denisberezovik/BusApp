//
//  TabBar.swift
//  BusApp
//
//  Created by REEMOTTO on 22.08.22.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: ViewController(), title: NSLocalizedString(LocalizedString.ViewController.booking, comment: ""), image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: TicketsViewController(), title: NSLocalizedString(LocalizedString.ViewController.tickets, comment: ""), image: UIImage(systemName: "ticket")!),
            createNavController(for: MoreViewController(), title: NSLocalizedString(LocalizedString.ViewController.info, comment: ""), image: UIImage(systemName: "info")!)
        ]
    }
}
