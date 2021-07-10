//
//  DetailView.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import UIKit
import SnapKit
import WebKit

class DetailView: UIViewController {
    
    var presenter: DetailPresenter!
    
    let web = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setWebView()
        self.showTranslation()
    }
}

extension DetailView: DetailViewProtocol {
    func showTranslation() {
        self.presenter.setWebView()
    }
    
    private func setWebView() {
        self.view.addSubview(self.web)
        web.snp.makeConstraints { make in
            make.right.bottom.left.top.equalToSuperview()
        }
    }
}
