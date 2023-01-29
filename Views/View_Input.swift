//
//  View_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 29.01.2023.
//

import SwiftUI

struct View_Input: View {
    @State var waterCups = [100,200,300,400]
    // stride(from: 100, to: 400, by: 100)
    
    @State private var addWater = 0
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Picker("Add Water", selection: $addWater) {
                    ForEach(waterCups, id: \.self) {
                        Text($0, format: .number)
                    }
                } // End of Picker
                .pickerStyle(.segmented)
//                .onChange(of: $waterCups, perform: {self.addWater = addWater + 200})
                
                Button(action: {self.addWater = 0}) {
                    Text("Reset")
                } // End of Button
                
                
//                Button(action: {self.addWater = addWater + 200}) {
//                    Text("Add 200")
//                } // End of Button
            
                
                
                
                Form {
                
                        Section {
                            TextField("Add Water", value: $addWater, format: .number)
                                .foregroundColor(.primary)
                        } header: {
                            Text("Add Water")
                        }
                        // End of Section
                        
                    
                    
                    
                } // End of Form
            } // End of VStack
        } // End of NavigationView
    } // End of some View
    
     
} // End of Main View

struct View_Input_Previews: PreviewProvider {
    static var previews: some View {
        View_Input()
    }
}
