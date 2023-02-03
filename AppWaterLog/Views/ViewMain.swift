//
//  View_Main.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI
import CoreData

struct ViewMain: View {
    
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    
    var body: some View {
        TabView {
            ViewToday()
                .tabItem {
                    Label("Today", systemImage: "drop")
                }

            ViewHistory()
                .tabItem {
                    Label("History", systemImage: "calendar")
                }

            ViewReport()
                .tabItem {
                    Label("Reports", systemImage: "chart.xyaxis.line")
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

struct View_Main_Previews: PreviewProvider {
    static var previews: some View {
        ViewMain()
    }
}
