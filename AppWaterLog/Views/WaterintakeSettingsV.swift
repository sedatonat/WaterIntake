//
//  View_Settings.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI

struct WaterintakeSettingsV: View {
    
    //    @ObservedObject var viewModel: DataFieldsWaterIntake
    
    @AppStorage("appearanceSelection") private var appearanceSelection: Int = 0
    
    var body: some View {
        NavigationView {
            
            Picker(selection: $appearanceSelection) {
                Text("System")
                    .tag(0)
                Text("Light")
                    .tag(1)
                Text("Dark")
                    .tag(2)
            } label: {
                Text("Select Appearance")
            }
            .pickerStyle(.menu)
        } // End of NavigationView
        
        .navigationTitle("Settings")
    }
}
}

struct WaterintakeSettingsV_Previews: PreviewProvider {
    static var previews: some View {
        WaterintakeSettingsV()
    }
}
