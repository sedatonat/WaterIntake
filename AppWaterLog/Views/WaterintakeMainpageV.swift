//
//  View_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 29.01.2023.
//

import SwiftUI


struct WaterintakeMainpageV: View {
    @Environment(\.colorScheme) var colorSchemeCurrent
    
    var body: some View {
        NavigationView {
            //            Text("...")
            VStack {
                
                Text("ColorScheme is: .\(String(describing: colorSchemeCurrent))")
                Text(String(
                    (String(describing: colorSchemeCurrent)) == "light" ? 0 : 1
                ))
            }
            .navigationTitle("Main Page")
        }
    }
}

struct WaterintakeMainpageV_Previews: PreviewProvider {
    static var previews: some View {
        WaterintakeMainpageV()
    }
}
