//
//  View_Main.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI

struct WaterintakeMainV: View {
    
    // MARK: Getting info
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    
    
    var body: some View {
        TabView {

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
        .environment(\.colorScheme, .light)
    }
}

struct WaterintakeMainV_Previews: PreviewProvider {
    static var previews: some View {
        WaterintakeMainV()
    }
}

