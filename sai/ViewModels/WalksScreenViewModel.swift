//
//  WalksScreenViewModel.swift
//  sai
//
//  Created by Николай Попов on 26.08.2023.
//

import Foundation
import SaiFastAPI

enum WalksScreenFilterState {
     case today, week, month, year
}

class WalksScreenViewModel: ObservableObject {
    @Published var stat: GetWalkDayActivityQuery.Data.GetWalkDayActivity? = nil
    
    func onAppear() {
        Network.shared.apollo.fetch(query: GetWalkDayActivityQuery(
            date: "2020-02-20T21:00:00Z"
        )) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let graphQLResult):
                self.stat = graphQLResult.data?.getWalkDayActivity
            case .failure(let error):
                print("Error loading data \(error)")
            }
        }
    
    }
}
