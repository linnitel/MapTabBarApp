//
//  MapViewController.swift
//  MapTabBarApp
//
//  Created by Yuliya Martsenko on 14.02.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var interactor: LocationInteractorOutputProtocol?
    fileprivate var locationManager = CLLocationManager()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private lazy var segmentView: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["standart", "satelite", "hybrid"])
        segment.tintColor = .white
        segment.backgroundColor = .systemBlue
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 5.0
        segment.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        return segment
    }()
    
    @objc
    func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    private lazy var myLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(showMyLocation(_:)),
                         for: .touchUpInside)
        let image = UIImage(named: "myLocationIcon.png")
        button.setImage(image, for: .normal)
        return button
    }()
    
    @objc
    func showMyLocation(_ sender: UIButton) {
        guard let coordinate = mapView.userLocation.location?.coordinate else {
            print("Can't access user location")
            return
        }
        let myLocation = CLLocation(latitude: coordinate.latitude,
                                         longitude: coordinate.longitude)
        mapView.centerToLocation(myLocation)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupViews() {
        mapView.delegate = self
        view.backgroundColor = .white
        view.addSubview(mapView)
        view.addSubview(segmentView)
        view.addSubview(myLocationButton)
    }
    
    private func setupMap() {
        guard let interactor = interactor else {
            return
        }
        
        let firstLocation = interactor.locations[interactor.activeLocationIndex]
        let initialLocation = CLLocation(latitude: firstLocation.coordinate.latitude,
                                         longitude: firstLocation.coordinate.longitude)
        mapView.centerToLocation(initialLocation)
        
        
        for location in interactor.locations {
            mapView.addAnnotation(location)
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        // Check for Location Services
        if CLLocationManager.locationServicesEnabled() {
            print("Location service enabled")
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.showsBackgroundLocationIndicator = true
            mapView.showsUserLocation = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentView.center.x = self.view.center.x
        segmentView.center.y = self.view.center.y + (self.view.center.y / 1.7)
        myLocationButton.frame = CGRect(x: segmentView.frame.maxX + 5, y: segmentView.frame.minY, width: segmentView.frame.height, height: segmentView.frame.height)
        
    }

}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? LocationModel else {
            return nil
        }
        
        let identifier = "location"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation,
                                          reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.markerTintColor = annotation.markerColor
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {}
