//
//  StoreDetail.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/04.
//

import SwiftUI

struct StoreDetail: View {
    @ObservedObject var store: Store
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        TabView {
            StoreDetailContent(store: store)
                .tabItem {
                    Image(systemName: "exclamationmark.circle.fill")
                    Text("店舗情報")
                }
            StoreDetailMenu()
                .tabItem {
                    Image(systemName: "filemenu.and.cursorarrow")
                    Text("お酒の種類")
                }
        }
    }
}

struct StoreDetail_Previews: PreviewProvider {
    
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        let newStore = Store(context: viewContext)
        StoreDetail(store:newStore).environment(\.managedObjectContext, viewContext)
    }
}
