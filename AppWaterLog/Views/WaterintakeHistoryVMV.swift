//
//  ViewInput.swift
//  SOPS001X
//
//  Created by Sedat Onat on 3.02.2023.
//

import SwiftUI
import CoreData

@MainActor
final class ViewModelHistory: ObservableObject {
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
        static func == (lhs: ViewModelHistory.Item, rhs: ViewModelHistory.Item) -> Bool {
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
                    intakeDate: Date.now,
                    intakeType: "Water",
                    intakeAmount: 0.0)
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


//// MARK: Sorting Direction Enum: Works
//enum SortDirection {
//    case asc
//    case desc
//}
////----


struct ViewHistory: View {
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    @StateObject var viewModel: ViewModelHistory
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
//    // MARK: Sorting Direction: Works
//    @State private var sortDirection: SortDirection = .asc
//    var sortDirectionText: String {
//        sortDirection == .asc ? "Sort Ascending" : "Sort Descending"
//    }
//    //----
    
//    // MARK: Sorting Function
//    private func performSort(sortDirection: SortDirection) {
//        var sortedDFWI: [DataFieldsWaterIntake]  // Local variable
//        switch sortDirection {
////        default : .asc
//
//        case .asc:
//            sortedDFWI.sort { lhs, rhs in
//                lhs.intakeType < rhs.intakeType
//            }
//        case .desc:
//            sortedDFWI.sort { lhs, rhs in
//                lhs.intakeType > rhs.intakeType
//            }
//        }
//    } // End of func
//    //----
  
    
    var body: some View {
        
        NavigationView {
            List($viewModel.items) { $item in
                VStack(alignment: .leading) {
                    Text(item.dataFieldsWaterIntake.intakeDate.formatted(.dateTime))
                    Text(item.dataFieldsWaterIntake.intakeType)
                    Text("\(item.dataFieldsWaterIntake.intakeAmount.formatted(.number)) ml.")
                }
                .onTapGesture {
                    viewModel.selectedDataFieldsWaterIntake = item.dataFieldsWaterIntake
                }
                
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(action: item.delete) { Label("Delete", systemImage: "trash") }.tint(.red)
                }
                
//                // MARK: Perform Sorting
//                .onChange(of: sortDirection, perform: performSort)
//                //----
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.add() }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            
//            // MARK: Sort Button: Works
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(sortDirectionText) {
//                        sortDirection = sortDirection == .asc ? .desc: .asc
//                    }
//                }
//            }
//            //----
            
            .navigationTitle("History")
        }
        
        
        
        .navigationViewStyle(.stack)
        .task {
            await viewModel.subscribe()
        }
        .sheet(item: $viewModel.selectedDataFieldsWaterIntake) { dataFieldsWaterIntake in
            WaterintakeHistoryEditV(viewModel: .init(dataFieldsWaterIntake: dataFieldsWaterIntake, storageService: storageService))
        }
        
        
    }
    
}


// FIXME: Gives error
//struct ViewHistory_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewHistory()
//    }
//}
