//
//  SOPS001XApp.swift
//  SOPS001X
//
//  Created by Sedat Onat on 29.01.2023.
//

import SwiftUI

@main
struct SOPS001XApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            View_Input()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
