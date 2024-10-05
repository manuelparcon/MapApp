//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Manuel Parcon on 10/5/24.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewmodel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    @Published var mapLocation: Location {
        didSet {
            updateMapRegon(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MapCameraPosition = .region(MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
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
    
}
