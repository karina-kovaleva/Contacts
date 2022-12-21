//
//  TabBarController.swift
//  Lesson 3
//
//  Created by Karina Kovaleva on 19.12.22.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        guard let personImage = UIImage(systemName: "person") else { return }
        guard let favoriteImage = UIImage(systemName: "star") else { return }
        let contactListViewController = UINavigationController(rootViewController: ContactListViewController())
        contactListViewController.tabBarItem.title = "Contacts"
        contactListViewController.tabBarItem.image = personImage
        let favoriteContactsViewController = FavoriteContactsViewController()
        favoriteContactsViewController.tabBarItem.title = "Favorite"
        favoriteContactsViewController.tabBarItem.image = favoriteImage
        viewControllers = [contactListViewController, favoriteContactsViewController]
    }
}
