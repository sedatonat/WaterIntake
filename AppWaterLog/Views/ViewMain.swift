//
//  View_Main.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI
//import CoreData

struct ViewMain: View {
    
    // MARK: Getting info
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    
    
    var body: some View {
        TabView {
            
            // FIXME: Activate this
//            ViewMainpage()
//                .tabItem {
//                    Label("Today", systemImage: "drop")
//                }

            
            ViewHistory(viewModel: .init(storageService: storageService))
                .tabItem {
                    Label("History", systemImage: "calendar")
                }

            ViewStats()
                .tabItem {
                    Label("Stats", systemImage: "chart.xyaxis.line")
                }
            
            ViewInsights()
                .tabItem {
                    Label("Insights", systemImage: "exclamationmark.bubble")
                }

            ViewSettings()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        } // End of TabView
    }
}

struct ViewMain_Previews: PreviewProvider {
    static var previews: some View {
        ViewMain()
    }
}

