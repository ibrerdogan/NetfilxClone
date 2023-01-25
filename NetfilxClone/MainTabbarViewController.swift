//
//  ViewController.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 30.11.2022.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        let service = ServiceAPI()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController(service: service))
        let vc2 = UINavigationController(rootViewController: UpcomingViewController(service: service))
        let vc3 = UINavigationController(rootViewController: SearchViewController(service: service))
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Coming Soon"
        vc3.tabBarItem.title = "Search"
        vc4.tabBarItem.title = "Downloads"
        tabBar.tintColor = .label
        
        
        setViewControllers([vc1,vc2
                           ,vc3,vc4], animated: true)
        
        
    }


}

