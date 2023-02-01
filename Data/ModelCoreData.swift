//
//  Model_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 31.01.2023.
//

import Foundation
import CoreData

class ClassDataIntake: NSManagedObject, Identifiable {
    @NSManaged var intakeAmount: Int
    @NSManaged var intakeDate: Date
    @NSManaged var intakeID: UUID
    @NSManaged var intakeType: String
    @NSManaged var timeStamp: Date
}

extension ClassDataIntake {
    static func getListItemFetchRequest() -> NSFetchRequest<ClassDataIntake>{
        let request = ClassDataIntake.fetchRequest() as! NSFetchRequest<ClassDataIntake>
        request.sortDescriptors = [NSSortDescriptor(key: "intakeID", ascending: false)]
        return request
    }
}
