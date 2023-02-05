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
                    intakeDate: .now,
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

struct ViewHistory: View {
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    @StateObject var viewModel: ViewModelHistory

    var body: some View {
        
        NavigationView {
            List($viewModel.items) { $item in
                VStack(alignment: .leading) {
//                    Text(item.dataFieldsWaterIntake.id)
                    Text(item.dataFieldsWaterIntake.intakeDate.formatted(.dateTime.day().month().year()))
                    Text(item.dataFieldsWaterIntake.intakeType)
                    Text(item.dataFieldsWaterIntake.intakeAmount.formatted(.number))
//                    EmptyView()
                }
                .onTapGesture {
                    viewModel.selectedDataFieldsWaterIntake = item.dataFieldsWaterIntake
                }

                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(action: item.delete) { Label("Delete", systemImage: "trash") }.tint(.red)
                }
            }
            
            // MARK: Save _ Start
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { viewModel.add() }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            // MARK: Save _ Finish
            
            
            .navigationTitle("History")
        }
        
        
        
        .navigationViewStyle(.stack)
        .task {
            await viewModel.subscribe()
        }


        
    }
}


// FIXME: Gives error
//struct ViewHistory_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewHistory()
//    }
//}
