////
////  View_History.swift
////  SOPS001X
////
////  Created by Sedat Onat on 30.01.2023.
////
//
//import SwiftUI
//
//@MainActor
//final class ViewModelMainpage: ObservableObject {
//    @Published var dataFieldsWaterIntake: DataFieldsWaterIntake
//    @Published var isComplete: Bool
//    private(set) var save: () async throws -> Void = { }
//    init(
//        dataFieldsWaterIntake: DataFieldsWaterIntake,
//        storageService: StorageServiceProtocol
//    ) {
//        self.dataFieldsWaterIntake = dataFieldsWaterIntake
//        isComplete = dataFieldsWaterIntake.completed != nil
//        $isComplete
//            .dropFirst()
//            .compactMap { [weak self] isComplete in
//                guard var copy = self?.dataFieldsWaterIntake else { return nil }
//                copy.completed = isComplete ? Date.now : nil
//                return copy
//            }
//            .assign(to: &$dataFieldsWaterIntake)
//        save = { [weak self] in
//            guard let dataFieldsWaterIntake = self?.dataFieldsWaterIntake else { return }
//            try await storageService.update(dataFieldsWaterIntake: dataFieldsWaterIntake)
//        }
//    }
//}
//
//struct ViewMainpage: View {
//    @StateObject var viewModel: ViewModelMainpage
//    @Environment(\.presentationMode) private var presentationMode
//    @FocusState private var isFocused: Bool
//    var body: some View {
//
//        NavigationView {
//            VStack(alignment: .leading) {
////                TextField("Date & Time", text: $viewModel.dataFieldsWaterIntake.intakeDate, prompt: Text("Edit the Date"))
//
//                TextField("Type", text: $viewModel.dataFieldsWaterIntake.intakeType, prompt: Text("Edit the Type"))
//                    .focused($isFocused)
////                TextField("Amount", text: $viewModel.dataFieldsWaterIntake.intakeAmount, prompt: Text("Edit the Amount"))
//                Toggle("Completed", isOn: $viewModel.isComplete)
//                    .toggleStyle(.button)
//                Spacer()
//            }
//            .task {
//                await Task.sleep(UInt64(0.25e9))
//                isFocused = true
//            }
//            .textFieldStyle(.roundedBorder)
//
//
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button {
//                        Task {
//                            try? await viewModel.save()
//                            presentationMode.wrappedValue.dismiss()
//                        }
//                    } label: {
//                        Text("Done")
//                    }
//                }
//            }
//
//
//            .navigationTitle("Edit To Do")
//            .padding()
//        }
//    }
//}
//
