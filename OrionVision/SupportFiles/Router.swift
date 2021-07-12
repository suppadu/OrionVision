//
//  Router.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import UIKit

protocol RouterMain {
    var navController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initViewController()
    func showDetail(id: Int)
}

class Router: RouterProtocol {
    
    var navController: UINavigationController?
    
    var builder: BuilderProtocol?
    var search = UISearchController(searchResultsController: nil)
    
    init(navController: UINavigationController, builder: BuilderProtocol) {
        self.navController = navController
        self.builder = builder
    }
    
    func initViewController() {
        if let navController = self.navController{
            guard let mainViewController = self.builder?.createMainModule(router: self) else { return }
            navController.viewControllers = [mainViewController]
            navController.navigationBar.backgroundColor = .systemBackground
        }
    }
    
    func showDetail(id: Int) {
        if let navController = self.navController{
            guard let detailViewController = self.builder?.createDetailModule(id: id, router: self) else { return }
            navController.pushViewController(detailViewController, animated: true)
            navController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
    }
}
