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
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                TextField("intakeType", text: $viewModel.dataFieldsWaterIntake.intakeType, prompt: Text("Edit Intake Type"))
                    .focused($isFocused)
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


