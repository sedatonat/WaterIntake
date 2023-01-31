//
//  Model_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 31.01.2023.
//

import Foundation
import CoreData

class DataIntake: NSManagedObject, Identifiable {
    @NSManaged var intakeAmount: Int
    @NSManaged var intakeDate: Date
    @NSManaged var intakeID: UUID
    @NSManaged var intakeType: String
}

extension DataIntake {
    static func getListItemFetchRequest() -> NSFetchRequest<DataIntake>{
        let request = DataIntake.fetchRequest() as! NSFetchRequest<DataIntake>
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        return request
    }
}
