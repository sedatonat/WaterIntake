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
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                TextField("intake Type", text: $viewModel.dataFieldsWaterIntake.intakeType, prompt: Text("Edit Intake Type"))
                    .focused($isFocused)
                
//                DatePicker(selection: $viewModel.dataFieldsWaterIntake.intakeDate, in: ...Date(), displayedComponents: .date) {
//                                Text("date")
//                }
//                            Text("Date is \(birthDate, formatter: dateFormatter)")
//                        }.labelsHidden()
                
                DatePicker("Edit Date", selection: $viewModel.dataFieldsWaterIntake.intakeDate, in: ...Date.now)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                
                
//                TextField("intake Date & Time", text: $viewModel.dataFieldsWaterIntake.intakeDate, prompt: Text("Edit Intake Date & Time"))
                
//                TextField("intakeAmount", text: $viewModel.dataFieldsWaterIntake.intakeAmount, prompt: Text("Edit Intake Amount"))
                
                Spacer()
            }
            .textFieldStyle(.roundedBorder)
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
            
            
            .navigationTitle("Edit Water Intake")
            .padding()
        }
        
    }
}



