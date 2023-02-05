//
//  View_Settings.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI

struct WaterintakeSettingsV: View {
    
    @Environment(\.colorScheme) var colorSchemeCurrent
    @AppStorage("colorSchemeSelection") var colorSchemeSelection = 0

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $colorSchemeSelection) {
                        Text("Light")
                            .tag(0)
                        Text("Dark")
                            .tag(1)
                    } label: {
                        Text("Select Color Scheme")
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Pick the Color Scheme")
                        .font(.system(.title3))
                        .fontWeight(.bold)
                        .textCase(nil)
                }
                .padding()
            }
            
        } // End of NavigationView
        
        .navigationTitle("Settings")
        .preferredColorScheme(colorSchemeSelection == 0 ? .light : .dark)
    }
        
}


struct WaterintakeSettingsV_Previews: PreviewProvider {
    static var previews: some View {
        WaterintakeSettingsV()
    }

}
