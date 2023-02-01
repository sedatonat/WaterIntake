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
    @NSManaged var intakeDate: String
    @NSManaged var intakeID: UUID
    @NSManaged var intakeType: String
}

extension ClassDataIntake {
    static func getListItemFetchRequest() -> NSFetchRequest<ClassDataIntake>{
        let request = ClassDataIntake.fetchRequest() as! NSFetchRequest<ClassDataIntake>
        request.sortDescriptors = [NSSortDescriptor(key: "intakeID", ascending: false)]
        return request
    }
}
