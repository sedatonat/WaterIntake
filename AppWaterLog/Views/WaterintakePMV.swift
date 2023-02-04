//
//  View_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 29.01.2023.
//


import SwiftUI

struct WaterintakePMV: View {
    
    
    let waterCups = [100,200,300,400]
    // stride(from: 100, to: 400, by: 100)
    
    @State private var waterIntakeOldValue = 0
    @State private var waterIntakePickerValue = 0
    @State private var waterIntakeCurrentValue = 0
    @FocusState private var xxxIsFocused: Bool
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                let waterIntakeOldValue = waterIntakeCurrentValue
//                Text("Old value is \(waterIntakeOldValue)")
                
                Divider()
                
                Section {
                    Picker("Choose the amount", selection: $waterIntakePickerValue) {
                        ForEach(waterCups, id: \.self) {
                            Text($0, format: .number)
                        } // End of ForEach
                    } // End of Picker
                    .pickerStyle(.segmented)
                } header: { Text("Pick the amount") }
                // End of Section
                
                Divider()
                
//                Text("Picker value is \(waterIntakePickerValue)")
                
                
                Button(action: {self.waterIntakeCurrentValue = waterIntakeOldValue + waterIntakePickerValue}) {
                    Text("Add to Curent")
                } // End of Button
                
                
                Form {
                    Section {
                        
                        TextField("Drink Water", value: $waterIntakeCurrentValue, format: .number)
                            .foregroundColor(.primary)
                            .keyboardType(.numberPad)
                            .focused($xxxIsFocused) // trigers the state
                    } header: { Text("Daily Water Intake - Current") }
                    // End of Section
                    Button(action: {self.waterIntakeCurrentValue = 0}) {
                        Text("Reset")
                    } // End of Button
                    
                } // End of Form
            } // End of VStack
            
            
            
            .navigationTitle("Daily Water Intake")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer() // brought Done to the right side
                    Button("Done") {
                        xxxIsFocused = false
                    }
                }
            }
            
            
        } // End of NavigationView
        
    } // End of some View
} // End of Main View

struct WaterintakePMV_Previews: PreviewProvider {
    static var previews: some View {
        WaterintakePMV()
    }
}





//                        .onChange(of: waterIntake) { [waterIntake] newState in
//                            print(waterIntake, self.waterIntake, newState)
//                        } // hatasiz
