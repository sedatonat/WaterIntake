//
//  View_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 29.01.2023.
//


import SwiftUI

struct View_Input: View {
    let waterCups = [100,200,300,400]
    // stride(from: 100, to: 400, by: 100)
    
    @State private var waterIntake = 0
    @State private var waterIntakeOldvalue = 0
    @FocusState private var xxxIsFocused: Bool
    
    
    var body: some View {
        NavigationView {
            
                VStack {
                    
                    Section {
                        
                        let waterIntakeOldvalue = waterIntake
                        
                        
                        Picker("Choose the amount", selection: $waterIntake) {
                            ForEach(waterCups, id: \.self) {
                                Text($0, format: .number)
                            }
                        } // End of Picker
                        .pickerStyle(.segmented)
                        
                        
                        
//                        .onChange(of: waterIntake) { [waterIntake] newState in
//                            print(waterIntake, self.waterIntake, newState)
//                        } // hatasiz
                        
                        
                        Button(action: {self.waterIntake = 0}) {
                            Text("Reset")
                        } // End of Button

//                        Text("\(waterCups)" as String)

                        
                        

                        
                        
                        //                        .onTapGesture {
    //                            self.waterIntake = waterIntake + 10
    //                        } // onTapGesture adds 200

                    } header: { Text("Pick the amount") }
                    
                    
                    
                    
                    Form {
                        Section {
                            Text("old value is \(waterIntakeOldvalue)")
                            TextField("Drink Water", value: $waterIntake, format: .number)
                                .foregroundColor(.primary)
                                .keyboardType(.numberPad)
                                .focused($xxxIsFocused) // trigers the state
                        } header: { Text("Daily Water Intake") }
                            
                        
                        // End of Section
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

struct View_Input_Previews: PreviewProvider {
    static var previews: some View {
        View_Input()
    }
}
