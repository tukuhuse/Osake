//
//  addCategoryList.swift
//  osake
//
//  Created by 高橋優人 on 2021/06/30.
//

import SwiftUI
import CoreData

struct addCategoryList: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @State var newCategoryName: String = ""
    @Binding var addflag: Bool
    @Binding var kind: Category.kind
    
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    var body: some View {
        HStack {
            TextField("カテゴリー名を入力", text: $newCategoryName).textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            Button(action: {
                self.addflag = false
                Category.create(in: viewContext, name: newCategoryName, kind: self.kind)
                save()
            }, label: {
                Text("保存")
            })
        }
    }
}

struct addCategoryList_Previews: PreviewProvider {
    
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        return addCategoryList(addflag: .constant(true), kind: .constant(.liquor)).environment(\.managedObjectContext, viewContext)
    }
}
