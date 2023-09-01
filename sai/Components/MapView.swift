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
        mapView.setUserTrackingMode(.none, animated: true)
        mapView.delegate = context.coordinator
        
        mapView.setRegion(getCoordianteRegion(), animated: true)
        
        setOverlay(mapView)
    
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        setOverlay(uiView)
        uiView.setRegion(getCoordianteRegion(), animated: true)
    }
    
    private func getLocationHistoryPolyline() -> MKOverlay {
        let line = MKPolyline(coordinates: locationHistory, count: locationHistory.count)
        
        return line
    }
    
    private func setOverlay(_ uiView: MKMapView) {
        uiView.removeOverlays(uiView.overlays)
        let line = getLocationHistoryPolyline()
        
        uiView.addOverlay(line)
    }
    
    
    private func getCoordianteRegion() -> MKCoordinateRegion {
        if(locationHistory.isEmpty) {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 50.39644, longitude: 30.5488),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }
        
        let polygon = getLocationHistoryPolyline()
        var boundingMapRect = polygon.boundingMapRect
        
        boundingMapRect.size = MKMapSize(width: boundingMapRect.size.width * 1.4, height: boundingMapRect.size.height * 1.4)
        
        var region = MKCoordinateRegion(boundingMapRect)
        region.center.longitude -= region.span.longitudeDelta / 3.75
        
        return region
    
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .white
            renderer.lineWidth = 2
            return renderer
        }
    }
    
    typealias UIViewType = MKMapView
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let locationHistory: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 50.39644, longitude: 30.5488),
            CLLocationCoordinate2D(latitude: 50.38644, longitude: 30.4488)
        ]

        
        MapView(
            locationHistory: locationHistory
        )
        .preferredColorScheme(.dark)
    }
}
