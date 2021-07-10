//
//  ViewController.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    
    var table: VideosTableView!
    var presenter: MainPresenterProtocol!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(table)
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

