//
//  Location.swift
//  MapApp
//
//  Created by Manuel Parcon on 10/5/24.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // id for Identifiable
    var id: String {
        name + cityName
    }
    
    // for conforming to Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        // what logic should be used to determine that the lefthand side Location and the righthand side Location are the exact same location
        lhs.id == rhs.id
    }
}
