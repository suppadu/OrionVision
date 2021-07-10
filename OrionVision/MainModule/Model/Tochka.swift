//
//  Tochka.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import Foundation
import MapKit

class Tochka: NSObject, MKAnnotation {
    let title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
}
