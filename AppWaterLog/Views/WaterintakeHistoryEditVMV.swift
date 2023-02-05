//
//  MainPage
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI

@MainActor
final class WaterintakeHistoryEditVM: ObservableObject {
    @Published var dataFieldsWaterIntake: DataFieldsWaterIntake
    private(set) var save: () async throws -> Void = { }
    init(
        dataFieldsWaterIntake: DataFieldsWaterIntake,
        storageService: StorageServiceProtocol
    ) {
        self.dataFieldsWaterIntake = dataFieldsWaterIntake
        save = { [weak self] in
            guard let dataFieldsWaterIntake = self?.dataFieldsWaterIntake else { return }
            try await storageService.update(dataFieldsWaterIntake: dataFieldsWaterIntake)
        }
    }
}

struct WaterintakeHistoryEditV: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    @StateObject var viewModel: WaterintakeHistoryEditVM
    @FocusState private var isFocused: Bool
    
    // TODO: Different formats for every format.
    let formatToDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    //----
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // TODO: Will Pick from a list, defined in Settings Menu
                    TextField("Choose Intake Type", text: $viewModel.dataFieldsWaterIntake.intakeType, prompt: Text("Edit Intake Type").foregroundColor(.accentColor))
                        .focused($isFocused)
                        .keyboardType(.alphabet)
                    //----
                    
                    // TODO: Data edtered dates maybe higlighted as rings
                    DatePicker("Pick Date & Time", selection: $viewModel.dataFieldsWaterIntake.intakeDate, in: ...Date.now)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    //----
                    
                    
                    // TODO: Will Pick from a list, defined in Settings Menu
                    TextField("intakeAmount", value: $viewModel.dataFieldsWaterIntake.intakeAmount, formatter: formatToDecimal, prompt: Text("Edit Intake Amount in 'ml.'").foregroundColor(.accentColor))
                        .focused($isFocused)
                        .keyboardType(.numberPad)
                    //----
                    
                    Spacer()
                    
                    // MARK: Hide the keyboard.
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Close the Keyboard") {
                                    isFocused = false
                                }
                            }
                        }
                    //----
                    
                }
                .textFieldStyle(.roundedBorder)
                
                // TODO: On Openning it immediately creates a record even if not defined anything. In new record if nothing entered should not be saved.
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            Task {
                                try? await viewModel.save()
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Text("Done")
                        }
                    }
                }
                //----
                
                .navigationTitle("Edit Water Intake")
                .padding()
            }
        }
    }
}



