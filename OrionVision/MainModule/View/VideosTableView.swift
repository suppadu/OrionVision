//
//  VideosTableView.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import UIKit
import MapKit

class VideosTableView: UITableView {
    
    let cellId = "VideoTableViewCell"
    var presenter: MainPresenter!
    var search: UISearchController!
    
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .systemBackground
        delegate = self
        dataSource = self
        rowHeight = UIScreen.main.bounds.height / 6
        register(VideoTableViewCell.self, forCellReuseIdentifier: self.cellId)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideosTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if search.isActive && search.searchBar.text != "" {
            return self.presenter.filteredCameras.count
        } else {
            return self.presenter.camerasAll.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! VideoTableViewCell
        let camera: CameraRawJSON
        if search.isActive && search.searchBar.text != "" {
            camera = self.presenter.filteredCameras[indexPath.row]
        } else {
            camera = self.presenter.camerasAll[indexPath.row]
        }
        cell.title.text = camera.title
        self.presenter.getImage(id: camera.id, number: NSNumber(value: camera.id)) { image in
            cell.img.image = image
        }
        DispatchQueue.global(qos: .utility).async{
            let lat = Double(camera.latitude ?? "56.106631")!
            let lon = Double(camera.longitude ?? "92.910105")!
            let tochka = Tochka(title: camera.title, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            DispatchQueue.main.async {
                cell.mapView.addAnnotation(tochka)
                cell.mapView.centerToLocation(CLLocation(latitude: lat, longitude: lon))
            }
        }
        
        return cell
    }
}

extension VideosTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id: Int
        if search.isActive && search.searchBar.text != "" {
            id = self.presenter.filteredCameras[indexPath.row].id
        } else {
            id = self.presenter.camerasAll[indexPath.row].id
        }
        self.search.isActive = false
        self.presenter.tapCamera(id: id)
    }
}
