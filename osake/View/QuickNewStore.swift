//
//  addStoreList.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/04.
//

import SwiftUI

struct QuickNewStore: View {
    
    @State var newStore: String = ""
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var keyboard = KeyboardObserver()
    
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
            Spacer()
            Button(action: {
                addNewStore()
            }) {
                Text("追加")
            }
            Spacer()
            Button(action: {
                cancelStore()
            }) {
                Text("Cancel").foregroundColor(.red)
            }
        }.onAppear(perform: {
            self.keyboard.startObserve()
        }).onDisappear(perform: {
            self.keyboard.stopObserve()
        }).padding(.bottom, self.keyboard.keyboardHeight)
        .animation(.easeOut)
    }
}

struct QuickNewStore_Previews: PreviewProvider {
    
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        QuickNewStore().environment(\.managedObjectContext, viewContext)
    }
}
