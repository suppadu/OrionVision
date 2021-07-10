//
//  Builder.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(id: Int, router: RouterProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = MainView()
        let tableView = VideosTableView()
        let presenter = MainPresenter(view: view,
                                      network: networkService,
                                      tableView: tableView,
                                      router: router)
        view.presenter = presenter
        view.table = tableView
        tableView.presenter = presenter
        return view
    }
    
    func createDetailModule(id: Int, router: RouterProtocol) -> UIViewController {
        let view = DetailView()
        let presenter = DetailPresenter(view: view,
                                        id: id,
                                        router: router)
        view.presenter = presenter
        return view
    }
}
