//
//  osakeApp.swift
//  osake
//
//  Created by 高橋優人 on 2021/06/27.
//

import SwiftUI

@main
struct osakeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //StoreSelect().environment(\.managedObjectContext, persistenceController.container.viewContext)
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
