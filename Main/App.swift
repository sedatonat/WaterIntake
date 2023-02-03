//
//  SOPS001XApp.swift
//  SOPS001X
//
//  Created by Sedat Onat on 29.01.2023.
//

import SwiftUI

@main
struct SOPS001XApp: App {
    @Environment(\.storageService) private var storageService: StorageServiceProtocol
    var body: some Scene {
        WindowGroup {
//            ViewReport(viewModel: .init(storageService: storageService))
            ViewMain()
        }
    }
}

extension EnvironmentValues {
    private struct StorageServiceKey: EnvironmentKey {
        static let defaultValue = StorageService()
    }
    var storageService: StorageServiceProtocol {
        StorageServiceKey.defaultValue
    }
}
