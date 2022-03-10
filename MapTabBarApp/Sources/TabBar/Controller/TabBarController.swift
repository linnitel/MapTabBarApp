//
//  TabBarController.swift
//  MapTabBarApp
//
//  Created by Yuliya Martsenko on 14.02.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    var interactor: LocationInteractorOutputProtocol?
    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        interactor = LocationInteractor()
//        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item2 = ListViewController()
        item2.interactor = interactor
        let item1 = MapViewController()
        item1.interactor = interactor
        item2.view.frame = view.bounds
        item1.view.frame = view.bounds
        let icon1 = UITabBarItem(title: "Map", image: UIImage(named: "mapIcon1.png"), selectedImage: UIImage(named:"mapIcon2.png"))
        let icon2 = UITabBarItem(title: "List", image: UIImage(named: "listIcon1.png"), selectedImage: UIImage(named: "listIcon2.png"))
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        let controllers = [item1, item2]
        self.viewControllers = controllers
    }
    
    override func viewWillLayoutSubviews() {
//        tabBar.frame.size.height = 150
//        tabBar.frame.origin.y = self.view.frame.size.height - 150
    }

}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        interactor?.activeLocationIndex = 1
         return true;
     }
}
