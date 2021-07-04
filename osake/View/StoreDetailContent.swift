//
//  StoreDetailContent.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/04.
//

import SwiftUI

struct StoreDetailContent: View {
    @ObservedObject var store: Store
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("店名")) {
                TextField("店名を入力", text: Binding($store.name, "new Store"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    }
}

struct StoreDetailContent_Previews: PreviewProvider {
    
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        let newStore = Store(context: viewContext)
        return StoreDetailContent(store: newStore).environment(\.managedObjectContext, viewContext)
    }
}
