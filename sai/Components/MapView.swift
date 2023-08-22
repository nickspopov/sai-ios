//
//  MapView.swift
//  iosApp
//
//  Created by Николай Попов on 07.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    var locationHistory: [CLLocationCoordinate2D]
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.delegate = context.coordinator
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: 50.3, longitude: 30.4
        ), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.2))
        
        setOverlay(mapView)
    
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        setOverlay(uiView)
    }
    
    func setOverlay(_ uiView: MKMapView) {
        let line = MKPolyline(coordinates: locationHistory, count: locationHistory.count)
        
        uiView.addOverlay(line)
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .red
            renderer.fillColor = .black
            renderer.lineWidth = 5
            return renderer
        }
    }
    
    typealias UIViewType = MKMapView
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let locationHistory = [
            CLLocationCoordinate2D(latitude: 50.39644, longitude: 30.5488),
            CLLocationCoordinate2D(latitude: 50.38644, longitude: 30.4488)
        ]

        
        MapView(
            locationHistory: locationHistory
        )
        .preferredColorScheme(.dark)
    }
}
