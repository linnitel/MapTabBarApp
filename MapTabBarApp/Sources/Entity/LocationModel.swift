//
//  LocationModel.swift
//  MapTabBarApp
//
//  Created by Yuliya Martsenko on 14.02.2022.
//

import Foundation
import MapKit

final class LocationModel: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var markerColor: UIColor
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, color: UIColor, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        markerColor = color
    }
    
}
