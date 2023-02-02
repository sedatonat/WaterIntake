//
//  View_History.swift
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI

struct ViewHistory: View {
    
    @ObservedObject var viewModel: ClassDataIntake
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                 
                    
                    
                    
                }
            } // End of VStack
                .navigationTitle("History")
        }
    }
}

struct ViewHistory_Previews: PreviewProvider {
    static var previews: some View {
        ViewHistory(viewModel: ClassDataIntake())
    }
}
