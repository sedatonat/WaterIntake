//
//  ViewInput.swift
//  SOPS001X
//
//  Created by Sedat Onat on 3.02.2023.
//

import SwiftUI
import CoreData

@MainActor
final class ViewModelViewAddWater: ObservableObject {
    @Published var items: [Item] = []
    @Published var selectedDataFieldsWaterIntake: DataFieldsWaterIntake?
    struct Item: Identifiable, Hashable {
        var id: UUID {
            dataFieldsWaterIntake.id
        }
        var dataFieldsWaterIntake: DataFieldsWaterIntake

        var delete: () -> Void
        func hash(into hasher: inout Hasher) {
            hasher.combine(dataFieldsWaterIntake)
        }
        static func == (lhs: ViewModelViewAddWater.Item, rhs: ViewModelViewAddWater.Item) -> Bool {
            lhs.dataFieldsWaterIntake == rhs.dataFieldsWaterIntake
        }
    }
    private(set) var subscribe: () async -> Void = { }
    private(set) var add: () -> Void = { }
    init(
        storageService: StorageServiceProtocol
    ) {
        add = { [weak self] in
            Task { [weak self] in
                let id = UUID()
                try? await storageService.create(dataFieldsWaterIntake: .init(
                    id: id,
                    intakeDate: .now,
                    intakeType: "x",
                    intakeAmount: 0)
                )
                self?.selectedDataFieldsWaterIntake = try await storageService.read(id)
            }
        }
        subscribe = { [weak self] in
            let itemStream = await storageService.dataFieldsWaterIntakes.map { dataFieldsWaterIntakes in
                dataFieldsWaterIntakes.map { dataFieldsWaterIntake in
                    Item(
                        dataFieldsWaterIntake: dataFieldsWaterIntake,
                        delete: {
                            Task {
                                try await storageService.delete(id: dataFieldsWaterIntake.id)
                            }
                        }
                    )
                }
            }
            for await items in itemStream {
                self?.items = items
            }
        }
    }

}

struct ViewAddWater: View {
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    @StateObject var viewModel: ViewModelViewAddWater

    
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
                
                Button(action: {self.waterIntakeCurrentValue = waterIntakeOldValue + self.waterIntakePickerValue}) {
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
                    
                    
                    
//                    Section {
//                        List {
//                            ForEach($viewModel, id: \.self) { item in
//                                Text("\(item.intakeDate)")
//                            }
//                        }
//
//
//
//                    } header: { Text("History") }
//                    
//                                        .toolbar {
//                                            Button {
//                                                let addToDataIntake = $viewModel(context: self.managedObjectContext)
//                                                addToDataIntake.id = UUID()
//                                                addToDataIntake.intakeDate = Date()
//                                                addToDataIntake.intakeAmount = 10
//                                                addToDataIntake.intakeType = "A"
//                                                // Save
//                                                do {
//                                                    try self.managedObjectContext.save()
//                                                } catch {
//                                                    print(error)
//                                                }
//                                            } label: { Label("Save", systemImage: "plus") }
//                                        }
                    
                    
                    
                } // End of Form
            } // End of VStack
            .navigationTitle("Daily Water Intake")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer() // brought Done to the right side
                    Button("Done") {
                        self.xxxIsFocused = false
                    }
                }
            }
        } // End of NavigationView
        
        
        
        
        .navigationViewStyle(.stack)
        .task {
            await viewModel.subscribe()
        }
//        .sheet(item: $viewModel.selectedDataFieldsWaterIntake) { dataFieldsWaterIntake in
//            ViewInput(viewModel: .init(dataFieldsWaterIntake: dataFieldsWaterIntake, storageService: storageService))
//        }
    }
}
