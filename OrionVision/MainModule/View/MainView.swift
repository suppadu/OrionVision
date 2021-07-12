//
//  ViewController.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import UIKit
import SnapKit

class MainView: UIViewController{
    
    var table: VideosTableView!
    var presenter: MainPresenter!
    var search: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.search.obscuresBackgroundDuringPresentation = false
        self.view.addSubview(table)
        self.search.searchResultsUpdater = self
        self.table.tableHeaderView = self.search.searchBar
        table.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
        self.takeCameras()
    }
}

extension MainView: MainViewProtocol {
    func takeCameras() {
        self.presenter.getCamerasInfo()
    }
}

extension MainView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.presenter.filteredCameras = filterCameras(for: self.search.searchBar.text ?? "", in: self.presenter.camerasAll)
        print("search")
        self.table.reloadData()
    }
    
    private func filterCameras(for searchText: String, in filterArray: [CameraRawJSON]) -> [CameraRawJSON] {
        let filteredCameras = filterArray.filter({ camera in
            return camera.title.lowercased().contains(searchText.lowercased())
        })
        return filteredCameras
    }
}

