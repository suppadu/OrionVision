//
//  CameraRawJSON.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import Foundation
import UIKit
import MapKit

struct CameraRawJSON: Codable {
    let id: Int
    let title: String
    let latitude: String?
    let longitude: String?
}

struct CameraWithImage {
    let id: Int
    let title: String
    let location: CLLocation?
    let img: UIImage?
}
