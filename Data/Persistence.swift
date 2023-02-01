//
//  Persistence.swift
//  SOPS001X
//
//  Created by Sedat Onat on 29.01.2023.
//

import CoreData
import CloudKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        
        // Sanki buraya data model ile alakali bilgiler eklenecek??? #learn
        for _ in 0..<10 {
            let newItem = ClassDataIntake(context: viewContext) // Item should be data
            newItem.timeStamp = Date()
            newItem.intakeAmount = Int()
            newItem.intakeDate = Date()
            newItem.intakeID = UUID()
            newItem.intakeType = String()

        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
        
        
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "SOPS001X")  // ???
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        
    }
}
