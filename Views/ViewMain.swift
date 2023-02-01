//
//  View_Main.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI
import CoreData

struct ViewMain: View {
    
    @ObservedObject var viewModel: ClassDataIntake
    
    var body: some View {
        TabView {
            ViewInput(viewModel: ClassDataIntake())
                .tabItem {
                    Label("Input", systemImage: "drop")
                }

            ViewHistory(viewModel: ClassDataIntake())
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }

            ViewReport(viewModel: ClassDataIntake())
                .tabItem {
                    Label("Reports", systemImage: "chart.xyaxis.line")
                }

            ViewSettings(viewModel: ClassDataIntake())
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        } // End of TabView
    }
}

struct View_Main_Previews: PreviewProvider {
    static var previews: some View {
        ViewMain(viewModel: ClassDataIntake())
    }
}
