//
//  LocationInteractor.swift
//  MapTabBarApp
//
//  Created by Yuliya Martsenko on 14.02.2022.
//

import Foundation
import MapKit

protocol LocationInteractorOutputProtocol {
    var locations: [LocationModel] { get }
    var activeLocationIndex: Int { get set }
}

final class LocationInteractor: LocationInteractorOutputProtocol {
    var locations: [LocationModel] =
        [.init(title: "Sete",
               subtitle: "International Museum of Modest Arts",
               color: .green,
               coordinate: CLLocationCoordinate2D(latitude: 43.411302921372524,
                                                  longitude: 3.6938797466935904)),
         .init(title: "Ecole 42",
               subtitle: "Ecole 42 campus in Paris",
               color: .red,
               coordinate: CLLocationCoordinate2D(latitude: 48.89813538370878,
                                                  longitude: 2.3190975142188295)),
         .init(title: "London",
               subtitle: nil,
               color: .blue,
               coordinate: CLLocationCoordinate2D(latitude: 51.522754289075884,
                                                  longitude: -0.12977760107820904)),
         .init(title: "Barcelona",
               subtitle: "La Sagrada Família",
               color: .purple,
               coordinate: CLLocationCoordinate2D(latitude: 41.40630686040833,
                                                  longitude: 2.1731972426383654))]
    var activeLocationIndex: Int = 1
}
