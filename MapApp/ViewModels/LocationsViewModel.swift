//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Manuel Parcon on 10/5/24.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    @Published var mapLocation: Location {
        didSet {
            updateMapRegon(location: mapLocation)
        }
    }
    
    // Current region on map
    @Published var mapRegion: MapCameraPosition = .region(MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        // Not good practice to force unwrap, but for this case, we know that locations will never be null
        self.mapLocation = locations.first!
        
        self.updateMapRegon(location: locations.first!)
    }
    
    private func updateMapRegon(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = .region(MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan))
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
}
