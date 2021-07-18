//
//  StoreDetailMenu.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/04.
//

import SwiftUI
import CoreData

struct StoreDetailMenu: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        List {
            Section(header: Text("蒸留酒")) {
                Text("ウイスキー")
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct StoreDetailMenu_Previews: PreviewProvider {
    
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        StoreDetailMenu().environment(\.managedObjectContext, viewContext)
    }
}
