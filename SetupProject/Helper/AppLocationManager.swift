//
//  AppLocationManager.swift
//  PushToTalk
//
//  Created by Kartum Infotech on 27/07/20.
//  Copyright © 2020 Sunil Zalavadiya. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class AppLocationManager: NSObject {
    static let shared = AppLocationManager()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    private var onLocationUpdateHandler: ((CLLocationCoordinate2D) -> ())?
    private var onLocationAccessCompletion: ((Bool) -> ())?
    private var forceForLocationPermission = false
    
    override init() {
        super.init()
        setupLocationManager()
        addNotificationObservers()
    }
    
    deinit {
        removeNotificationObservers()
        stopLocationUpdate()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .other
    }
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onApplicationWillEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func requestLocationServiceIfNeed(force: Bool, completionHandler: @escaping ((Bool) -> ())) {
        onLocationAccessCompletion = completionHandler
        forceForLocationPermission = force
        checkForLocationServicePermission()
    }
    
    func requestUserLocationServiceIfNeed(completionHandler: @escaping ((Bool) -> ())) {
        onLocationAccessCompletion = completionHandler
        checkForUserLocationServicePermission()
    }
    
    func isLocationPermissionGiven() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .restricted:
            return false
        @unknown default:
            break
        }
        return false
    }
    
    private func checkForLocationServicePermission() {
        DispatchQueue.main.async {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                self.onLocationAccessCompletion?(true)
            case .denied, .restricted:
                self.onLocationAccessCompletion?(false)
                if self.forceForLocationPermission {
                    Utility.showAlertForAppSettings(title: "We Can't Get Your Location", message: "To enable location service, you need to allow location service for this application from settings.", allowCancel: false) { (completed) in
                    }
                }
            @unknown default:
                break
            }
        }
        
    }
    
    private func checkForUserLocationServicePermission() {
        DispatchQueue.main.async {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                self.onLocationAccessCompletion?(true)
            case .denied, .restricted:
                self.onLocationAccessCompletion?(false)
                Utility.showAlertForAppSettings(title: "We Can't Get Your Location", message: "To enable location service, you need to allow location service for this application from settings.", allowCancel: true) { (completed) in
                }
                
            @unknown default:
                break
            }
        }
        
    }
    
    func startLocationUpdate(onLocationUpdate: @escaping ((CLLocationCoordinate2D) -> ())) {
        onLocationUpdateHandler = onLocationUpdate
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdate() {
        locationManager.stopUpdatingLocation()
        onLocationAccessCompletion = nil
        forceForLocationPermission = false
    }
   
    // MARK: - NotificationCenter events
    @objc private func onApplicationWillEnterForegroundNotification() {
        if forceForLocationPermission {
            checkForLocationServicePermission()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension AppLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkForLocationServicePermission()
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            return
        }
        currentLocation = manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
//        if !(location.coordinate.latitude == currentLocation.latitude && location.coordinate.longitude == currentLocation.longitude) {
            currentLocation = location.coordinate
            onLocationUpdateHandler?(currentLocation)
//        }
    }
}

