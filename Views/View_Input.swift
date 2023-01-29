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
    
    @State private var waterIntake = 0
    
    var body: some View {
        NavigationView {
            
                VStack {
                    
                    Section {
                        Picker("Choose the amount", selection: $waterIntake) {
                            ForEach(waterCups, id: \.self) {
                                Text($0, format: .number)
                            }
                        } // End of Picker
                        .pickerStyle(.segmented)
                        
                        
//                        .onTapGesture {
//                            self.addWater = addWater + 200
//                        } // onTapGesture adds 200
                       
                        
                        
                         // End of Button
                        
                        Button(action: {self.waterIntake = 0}) {
                            Text("Reset")
                        } // End of Button


                    } header: { Text("Pick the amount") }
                    
                    
                    Form {
                        Section {
                            TextField("Drink Water", value: $waterIntake, format: .number)
                                .foregroundColor(.primary)
                        } header: { Text("Daily Water Intake") }
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
