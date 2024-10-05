//
//  Location.swift
//  MapApp
//
//  Created by Manuel Parcon on 10/5/24.
//

import Foundation
import MapKit

struct Location: Identifiable {
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
}
