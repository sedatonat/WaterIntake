//
//  View_Main.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI
//import CoreData

struct WaterintakeMainV: View {
    
    // MARK: Getting info
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    
    
    var body: some View {
        TabView {
            
            // FIXME: Activate this
//            ViewMainpage()
//                .tabItem {
//                    Label("Today", systemImage: "drop")
//                }

            WaterintakeMainpageV()
                .tabItem {
                    Label("Main`", systemImage: "drop")
                }
            
            ViewHistory(viewModel: .init(storageService: storageService))
                .tabItem {
                    Label("History", systemImage: "calendar")
                }

            WaterintakeStatsV()
                .tabItem {
                    Label("Stats", systemImage: "chart.xyaxis.line")
                }
            
            WaterintakeInsightsV()
                .tabItem {
                    Label("Insights", systemImage: "exclamationmark.bubble")
                }

            WaterintakeSettingsV()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        } // End of TabView
    }
}

struct WaterintakeMainV_Previews: PreviewProvider {
    static var previews: some View {
        WaterintakeMainV()
    }
}

