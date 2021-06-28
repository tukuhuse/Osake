//
//  CategorySelect.swift
//  osake
//
//  Created by 高橋優人 on 2021/06/28.
//

import SwiftUI
import CoreData

struct CategorySelect: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    /*
    @State var categorylist: FetchRequest<Category>
    init(kind: Int16) {
        categorylist = FetchRequest<Category>(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], predicate: NSPredicate(format: "kind == %d", kind), animation: .default)
    }
    */
    
    let kind: Category.kind
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default) var CategoryList: FetchedResults<Category>
    
    //var kindlist: [Category.kind] = [.liquor,.spirit]
    
    var body: some View {
        Form {
            Section(header: Text("\(kind.toString())")) {
                List {
                    ForEach(CategoryList, id:\.self) { category in
                        if self.kind.rawValue == category.kind {
                            Text(category.name!)
                        }
                    }
                }
            }
        }
    }
}

struct CategorySelect_Previews: PreviewProvider {
    
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        
        Category.create(in: viewContext, name: "sample1", kind: .liquor)
        Category.create(in: viewContext, name: "sample2", kind: .spirit)
        
        return CategorySelect(kind: .liquor).environment(\.managedObjectContext, viewContext)
    }
}
