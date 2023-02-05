//
//  View_Settings.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI

struct WaterintakeSettingsV: View {
    
    @AppStorage("appearanceSelection") private var appearanceSelection: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
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
                } header: {
                    Text("Pick the Color Schema")
                        .font(.system(.title3))
                        .fontWeight(.bold)
                        .textCase(nil)
                }
                .padding()
            }
            
        } // End of NavigationView
        
        .navigationTitle("Settings")
    }
        
}


struct WaterintakeSettingsV_Previews: PreviewProvider {
    static var previews: some View {
        WaterintakeSettingsV()
    }
}
