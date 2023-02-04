//
//  MainPage
//  SOPS001X
//
//  Created by Sedat Onat on 30.01.2023.
//

import SwiftUI

@MainActor
final class ViewModelMainpage: ObservableObject {
    @Published var dataFieldsWaterIntake: DataFieldsWaterIntake
    private(set) var save: () async throws -> Void = { }
    init(
        dataFieldsWaterIntake: DataFieldsWaterIntake,
        storageService: StorageServiceProtocol
    )
    {
        self.dataFieldsWaterIntake = dataFieldsWaterIntake
    }
}

struct ViewMainpage: View {
    @StateObject var viewModel: ViewModelMainpage
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("...")
                Text("...")

                    .task {
                        await Task.sleep(UInt64(0.25e9))
                    }
                //            .textFieldStyle(.roundedBorder)
                
                
                
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                Task {
                                    try? await viewModel.save()
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
    
}

