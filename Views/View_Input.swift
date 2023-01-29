//
//  View_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 29.01.2023.
//

import SwiftUI

struct View_Input: View {
    @State private var addWaterCustom01 = 0
    @State private var addWaterCustom02 = 0
    @State private var addWaterCustom03 = 0
    @State private var addWater = 0
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Button(action: {self.addWater = addWater + 200}) {
                    Text("Add 200")
                }
                
                Form {
                    
                    Section {
                        TextField("Add Water", value: $addWater, format: .number)
                            .foregroundColor(.primary)
                    } header: {
                        Text("Add Water")
                    }
                    
                }
            }
        }
    }
}

struct View_Input_Previews: PreviewProvider {
    static var previews: some View {
        View_Input()
    }
}
