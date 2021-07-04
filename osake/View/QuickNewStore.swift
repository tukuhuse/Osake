//
//  addStoreList.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/04.
//

import SwiftUI

struct addStoreList: View {
    
    @State var newStore: String = ""
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func addNewStore() {
        Store.create(in: self.viewContext, name: self.newStore)
        self.newStore = ""
    }
    
    fileprivate func cancelStore() {
        self.newStore = ""
    }
    
    var body: some View {
        HStack {
            TextField("新しい店名", text: $newStore, onCommit: {
                addNewStore()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                addNewStore()
            }) {
                Text("追加")
            }
            Button(action: {
                cancelStore()
            }) {
                Text("Cancel").foregroundColor(.red)
            }
        }
    }
}

struct addStoreList_Previews: PreviewProvider {
    
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        addStoreList().environment(\.managedObjectContext, viewContext)
    }
}
