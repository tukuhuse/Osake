//
//  CategorySelect.swift
//  osake
//
//  Created by 高橋優人 on 2021/06/28.
//

import SwiftUI
import CoreData

struct CategorySelect: View {
    
    var body: some View {
        Form {
            ForEach(Category.kind.allCases, id: \.self) { categorykind in
                CategorySelectRow(kind: categorykind)
            }
        }
    }
}

struct CategorySelectRow: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default) var CategoryList: FetchedResults<Category>
    @State var kind: Category.kind
    @State var addflag: Bool = false
    
    /*
     @Environment(\.managedObjectContext) private var viewContext
     @ObservedObject var CategoryList: Category
     @Binding var kind: Category.kind
     @State var addflag: Bool = false
     */
    
    func deleteCategory(at offsets: IndexSet) {
        for index in offsets {
            let entity = CategoryList[index]
            viewContext.delete(entity)
        }
        do {
            try viewContext.save()
        } catch {
            print("Delete Error. \(offsets)")
        }
    }
    
    var body: some View {
        Section(header: HStack{
            Text("\(kind.toString())")
            Spacer()
            Button(action: {
                self.addflag = true
            }, label: {
                Text("追加")
            })
        }) {
            if self.addflag {
                addCategoryList(addflag: $addflag,kind: $kind)
            }
            ForEach(CategoryList, id:\.self) { category in
                if kind.rawValue == category.kind {
                    NavigationLink(destination: CategoryStoreList()) {
                        Text(category.name!)
                    }
                }
            }.onDelete(perform: deleteCategory)
        }
    }
}

struct CategorySelect_Previews: PreviewProvider {
    
    static let container = PersistenceController.shared.container
    static let viewContext = container.viewContext
    
    static var previews: some View {
        
        //テストデータの全削除
        let request = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "Category"))
        try! container.persistentStoreCoordinator.execute(request, with: viewContext)
        
        //醸造酒の初期データ
        Category.create(in: viewContext, name: "日本酒", kind: .liquor)
        Category.create(in: viewContext, name: "ビール", kind: .liquor)
        Category.create(in: viewContext, name: "ワイン", kind: .liquor)
        
        //蒸留酒の初期データ
        Category.create(in: viewContext, name: "焼酎", kind: .spirit)
        Category.create(in: viewContext, name: "ウイスキー", kind: .spirit)
        Category.create(in: viewContext, name: "ブランデー", kind: .spirit)
        Category.create(in: viewContext, name: "ウォッカ", kind: .spirit)
        
        return Form{
            CategorySelect().environment(\.managedObjectContext, viewContext)
        }
    }
}
