//
//  DetailPresenter.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import Foundation

protocol DetailViewProtocol {
    func showTranslation()
}

protocol DetailPresenterProtocol {
    init(view: DetailView, id: Int, router: RouterProtocol)
    func setWebView()
}

class DetailPresenter: DetailPresenterProtocol {
    
    let view: DetailView
    let id: Int
    let router: RouterProtocol
    
    required init(view: DetailView, id: Int, router: RouterProtocol) {
        self.view = view
        self.id = id
        self.router = router
    }
    
    func setWebView() {
        if let url = URL(string: "https://krkvideo1.orionnet.online/cam\(self.id)/embed.html"){
            let request = URLRequest(url: url)
            self.view.web.load(request)
        }
    }
}
