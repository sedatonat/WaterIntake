//
//  View_Main.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI

struct View_Main: View {
    
    var body: some View {
        TabView {
            View_Input()
                .tabItem {
                    Label("Input", systemImage: "drop")
                }

            View_History()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }

            View_Report()
                .tabItem {
                    Label("Report", systemImage: "chart.xyaxis.line")
                }

            View_Settings()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        } // End of TabView
//        .environmentObject(prospects)
    }
}

struct View_Main_Previews: PreviewProvider {
    static var previews: some View {
        View_Main()
    }
}
