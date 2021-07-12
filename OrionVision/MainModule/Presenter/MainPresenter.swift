//
//  MainPresenter.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import Foundation
import UIKit
import MapKit

protocol MainViewProtocol {
    func takeCameras()
}

protocol MainPresenterProtocol {
    init(view: MainView,
         network: NetworkService,
         tableView: VideosTableView,
         router: RouterProtocol)
    
    func getCamerasInfo()
    func tapCamera(id: Int)
    func getImage(id: Int, number: NSNumber, complit: @escaping (_ picture: UIImage?) -> Void)
}

class MainPresenter: MainPresenterProtocol {
    
    let view: MainView
    let network: NetworkService
    let tableView: VideosTableView
    let router: RouterProtocol
    var camerasAll: [CameraRawJSON] = []
    var filteredCameras: [CameraRawJSON] = []
    var cacheImage = NSCache<NSNumber, UIImage>()
    
    required init(view: MainView,
                  network: NetworkService,
                  tableView: VideosTableView,
                  router: RouterProtocol) {
        self.view = view
        self.network = network
        self.tableView = tableView
        self.router = router
    }
    
    func getCamerasInfo() {
        let getCamerasInfoQueue = DispatchQueue.global(qos: .utility)
        getCamerasInfoQueue.async {
            self.network.getCamerasAPI(){camerasJSON in
                self.camerasAll.append(contentsOf: camerasJSON)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tapCamera(id: Int) {
        self.router.showDetail(id: id)
    }
    
    func getImage(id: Int, number: NSNumber, complit: @escaping (_ picture: UIImage?) -> Void){
        if let cachedImage = self.cacheImage.object(forKey: number){
            complit(cachedImage)
        }else{
            self.network.getImage(id: id) { image in
                self.cacheImage.setObject(image!, forKey: number)
                DispatchQueue.main.async {
                    complit(image)
                }
            }
        }
    }
}
