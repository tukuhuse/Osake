//
//  StoreSelect.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/01.
//
import CoreData
import SwiftUI

struct StoreSelect: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.name, ascending: true)], animation: .default) var storeList: FetchedResults<Store>
    
    var body: some View {
        Form{
            List {
                ForEach(storeList, id:\.self) { store in
                    Text(store.name!)
                }
            }
        }
    }
}

struct StoreSelect_Previews: PreviewProvider {
    
    static let container = PersistenceController.preview.container
    static let viewContext = container.viewContext
    
    static var previews: some View {
        
        //テストデータの削除
        let request = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "Store"))
        try! container.persistentStoreCoordinator.execute(request, with: viewContext)
        
        //テストデータの初期化
        Store.create(in: viewContext, name: "花の舞")
        Store.create(in: viewContext, name: "鳥貴族")
        Store.create(in: viewContext, name: "和民")
        Store.create(in: viewContext, name: "山内農場")
        
        return StoreSelect().environment(\.managedObjectContext, viewContext)
    }
}
