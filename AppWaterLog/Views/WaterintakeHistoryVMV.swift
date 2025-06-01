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
    @Published var intakeDates: [StructIntakeDate] = []
    @Published var intakeTypes: [StructIntakeType] = []
    @Published var selectedDataFieldsWaterIntake: DataFieldsWaterIntake?
    
    // MARK: struct Item
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
    //---- End of struct Item
    
    // MARK: struct StructIntakeDate
    struct StructIntakeDate: Identifiable, Hashable, Equatable {
        var id: UUID {
            dataFieldsWaterIntake.id
        }
        
        var dataFieldsWaterIntake: DataFieldsWaterIntake
        
        var delete: () -> Void
        func hash(into hasher: inout Hasher) {
            hasher.combine(dataFieldsWaterIntake)
        }
        static func == (lhs: ViewModelHistory.StructIntakeDate, rhs: ViewModelHistory.StructIntakeDate) -> Bool {
            lhs.dataFieldsWaterIntake == rhs.dataFieldsWaterIntake
        }
    }
    //---- End of struct StructIntakeDate
    
    // MARK: struct StructIntakeType
    struct StructIntakeType: Identifiable, Hashable, Equatable {
        var id: UUID {
            dataFieldsWaterIntake.id
        }
        
        var dataFieldsWaterIntake: DataFieldsWaterIntake
        
        var delete: () -> Void
        func hash(into hasher: inout Hasher) {
            hasher.combine(dataFieldsWaterIntake)
        }
        static func == (lhs: ViewModelHistory.StructIntakeType, rhs: ViewModelHistory.StructIntakeType) -> Bool {
            lhs.dataFieldsWaterIntake == rhs.dataFieldsWaterIntake
        }
    }
    //---- End of struct StructIntakeType
    
    private(set) var subscribe: () async -> Void = { }
    private(set) var add: () -> Void = { }
    
    // MARK: init
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
                    StructIntakeDate(
                        dataFieldsWaterIntake: dataFieldsWaterIntake,
                        delete: {
                            Task {
                                try await storageService.delete(id: dataFieldsWaterIntake.id)
                            }
                        }
                    )
                }
            }
            for await intakeDates in itemStream {
                self?.intakeDates = intakeDates
                // DÜZELTME: items array'ini de dolduralım
                self?.items = intakeDates.map { intakeDate in
                    Item(
                        dataFieldsWaterIntake: intakeDate.dataFieldsWaterIntake,
                        delete: intakeDate.delete
                    )
                }
            }
        }
    } //---- End of init
    
} // End of VieModelHistory

struct ViewHistory: View {
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    @StateObject var viewModel: ViewModelHistory
    @State private var sortOrder: SortOrder = .dateDescending
    
    // Sort seçenekleri
    enum SortOrder: String, CaseIterable {
        case dateAscending = "Tarih (Eski → Yeni)"
        case dateDescending = "Tarih (Yeni → Eski)"
        case amountAscending = "Miktar (Az → Çok)"
        case amountDescending = "Miktar (Çok → Az)"
        case typeAscending = "Tür (A → Z)"
        case typeDescending = "Tür (Z → A)"
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(sortedIntakeDates, id: \.id) { item in
                    Section(header: Text("\(item.dataFieldsWaterIntake.intakeDate.formatted(date: .abbreviated, time: .omitted))")) {
                        
                        HStack(alignment: .center) {
                            Text(item.dataFieldsWaterIntake.intakeType)
                            Spacer()
                            Text(item.dataFieldsWaterIntake.intakeDate.formatted(date: .omitted, time: .shortened))
                            Spacer()
                            Text("\(item.dataFieldsWaterIntake.intakeAmount.formatted(.number)) ml.")
                        } // End of HStack
                        
                        .onTapGesture {
                            viewModel.selectedDataFieldsWaterIntake = item.dataFieldsWaterIntake
                        } // End of onTapGesture
                        
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Delete") {
                                // Orijinal array'den doğru item'ı bul ve sil
                                if let index = viewModel.intakeDates.firstIndex(where: { $0.id == item.id }) {
                                    let itemToDelete = viewModel.intakeDates[index]
                                    itemToDelete.delete()
                                }
                            }
                            .tint(.red)
                        } // End of swipeAction
                        
                    } // End of Section
                } // End of ForEach
            } // End of List
            
            .toolbar {
                // Mevcut Add butonu
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.add() }) {
                        Label("Add Item", systemImage: "plus")
                    } // End of Button
                } // End of ToolbarItem
                
                // YENİ: Sort butonu
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        ForEach(SortOrder.allCases, id: \.self) { order in
                            Button(action: {
                                sortOrder = order
                            }) {
                                HStack {
                                    Text(order.rawValue)
                                    if sortOrder == order {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                            .foregroundColor(.blue)
                    }
                } // End of Sort ToolbarItem
                
            } // End of toolbar
            
            .listStyle(.grouped)
            
            .navigationTitle("History")
        } // End of NavigationView
        
        .navigationViewStyle(.stack)
        
        .task {
            await viewModel.subscribe()
        } // End of .task
        
        .sheet(item: $viewModel.selectedDataFieldsWaterIntake) { dataFieldsWaterIntake in
            WaterintakeHistoryEditV(viewModel: .init(dataFieldsWaterIntake: dataFieldsWaterIntake, storageService: storageService))
        } // End of .sheet
        
    } // End of View
    
    // MARK: - Sıralama computed property (DÜZELTME: Doğru tip kullanıldı)
    private var sortedIntakeDates: [ViewModelHistory.StructIntakeDate] {
        switch sortOrder {
        case .dateAscending:
            return viewModel.intakeDates.sorted {
                $0.dataFieldsWaterIntake.intakeDate < $1.dataFieldsWaterIntake.intakeDate
            }
        case .dateDescending:
            return viewModel.intakeDates.sorted {
                $0.dataFieldsWaterIntake.intakeDate > $1.dataFieldsWaterIntake.intakeDate
            }
        case .amountAscending:
            return viewModel.intakeDates.sorted {
                $0.dataFieldsWaterIntake.intakeAmount < $1.dataFieldsWaterIntake.intakeAmount
            }
        case .amountDescending:
            return viewModel.intakeDates.sorted {
                $0.dataFieldsWaterIntake.intakeAmount > $1.dataFieldsWaterIntake.intakeAmount
            }
        case .typeAscending:
            return viewModel.intakeDates.sorted {
                $0.dataFieldsWaterIntake.intakeType < $1.dataFieldsWaterIntake.intakeType
            }
        case .typeDescending:
            return viewModel.intakeDates.sorted {
                $0.dataFieldsWaterIntake.intakeType > $1.dataFieldsWaterIntake.intakeType
            }
        }
    }
    
} // End of Struct
