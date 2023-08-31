//
//  ActiveWalkService.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import Foundation
import Combine

class ActiveWalkService: ObservableObject {
    let locationService = LocationService.shared
    
    @Published var activeWalk: Walk?
    @Published var isRunning = false
    @Published var timer = 0
    
    private var locationCancellable: AnyCancellable?
    private var timerCancellable: Cancellable?
    private let timerPublisher = Timer.publish(every: 1, on: .current, in: .common)
    
    func start() {
        locationService.requestPermission()
        isRunning = true
        activeWalk = Walk(startedAt: Date(), finishedAt: Date(), walkHistory: WalkHistoryModel(history: []))
        locationService.start()
        
        locationCancellable = locationService.currentLocationSubject
            .map({ clLocation in
                Location(latitude: clLocation!.coordinate.latitude, longitude: clLocation!.coordinate.longitude, timestamp: clLocation!.timestamp)
            })
            .sink { location in
                self.activeWalk?.walkHistory.addLocation(location)
            }
  
        timerCancellable = timerPublisher
            .autoconnect()
            .sink { _ in
                self.timer += 1
            }
    }
    
    func stop(){
        isRunning = false
        locationService.stop()
        locationCancellable?.cancel()
        timerCancellable?.cancel()
        timer = 0
    }
    
    static var shared = ActiveWalkService()
}
