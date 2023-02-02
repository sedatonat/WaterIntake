//
//  DataFields.swift
//  SOPS001X
//
//  Created by Sedat Onat on 2.02.2023.
//

import Foundation

struct DataFields: Hashable, Identifiable {
    var id: UUID
    var timeStamp: Date
    var intakeDate: Date
    var intakeType: String
    var intakeAmount: Double
}
