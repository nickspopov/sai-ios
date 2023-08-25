//
//  TripsWidget.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import SwiftUI

struct TripsWidget: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            mapView
            overlay
            info
        }.frame(
            maxWidth: .infinity,
            minHeight: 180,
            maxHeight: 180
        )
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(8)
    }
}

struct TripsWidget_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            TripsWidget()
            TripsWidget()
        }
        .padding(.horizontal, 16)
        .preferredColorScheme(.dark)
    }
}


// MARK: - Map
extension TripsWidget {
    var mapView: some View {
        MapView(locationHistory: [])
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .cornerRadius(8)
    }
}

// MARK: - Overlay
extension TripsWidget {
    var overlay: some View {
        VStack{}
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(
                LinearGradient(
                  stops: [
                    Gradient.Stop(color: .black.opacity(0.9), location: 0.0),
                    Gradient.Stop(color: .black.opacity(0.6), location: 0.6),
                    Gradient.Stop(color: .black.opacity(0.3), location: 1),
                  ],
                  startPoint: UnitPoint(x: 0, y: 0.5),
                  endPoint: UnitPoint(x: 1, y: 0.5)
                )
            )
    }
}

// MARK: - Info
extension TripsWidget {
    var info: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Typography("12.2 km", .semibold(.six))
                Typography("Distance", .regular(.eight))
                    .foregroundColor(Color(red: 0.64, green: 0.67, blue: 0.69))
                
            }
            VStack(alignment: .leading, spacing: 0) {
                Typography("32:12", .semibold(.six))
                Typography("Duration", .regular(.eight))
                    .foregroundColor(Color(red: 0.64, green: 0.67, blue: 0.69))
                
            }
        }
        .padding(10)
    }
}
