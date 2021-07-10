//
//  VideoTableViewCell.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import UIKit
import SnapKit
import MapKit

class VideoTableViewCell: UITableViewCell {
    
    private let constantWidth = 150
    private let constantHeight = 150
    
    let mapView = MKMapView()
    let mapCloseView = UIView()
    let img = UIImageView()
    let imgNuar = UIView()
    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        self.setMapView()
        self.setImgView()
        self.setTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.img.image = nil
    }

}

extension VideoTableViewCell {
    
    private func setImgView() {
        self.img.backgroundColor = .white
        self.img.contentMode = .scaleToFill
        self.setConstraintImg(self.img)
        self.imgNuar.backgroundColor = .black
        self.imgNuar.alpha = 0.4
        self.setConstraintImg(self.imgNuar)
    }
    
    private func setTitleLabel() {
        self.title.numberOfLines = 3
        self.title.font = UIFont(name: "AmericanTypewriter-Bold", size: 12)
        self.title.textColor = .white
        contentView.addSubview(self.title)
        self.title.snp.makeConstraints { make in
            make.left.equalTo(self.mapView.snp.right).offset(10)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.height.equalToSuperview()
        }
    }
    
    private func setMapView() {
        contentView.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
            make.width.equalTo(self.contentView.snp.height)
        }
    }
    
    private func setConstraintImg(_ view: UIView) {
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.equalTo(self.mapView.snp.right)
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
            make.right.equalToSuperview()
        }
    }
}

extension MKMapView {
    func centerToLocation(_ location: CLLocation,
                          radius: CLLocationDistance = 100){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: radius,
                                                  longitudinalMeters: radius)
        setRegion(coordinateRegion, animated: true)
    }
}
