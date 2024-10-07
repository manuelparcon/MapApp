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
    
    func nextButtonPressed() {
        // Get the curent index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        
        // Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is not valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
