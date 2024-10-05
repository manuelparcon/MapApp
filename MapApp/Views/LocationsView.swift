//
//  LocationsView.swift
//  MapApp
//
//  Created by Manuel Parcon on 10/5/24.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewmodel
    
    var body: some View {
        ZStack {
            Map(position: $vm.mapRegion)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewmodel())
}
