//
//  StoreDetailMenu.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/04.
//

import SwiftUI
import CoreData

struct StoreDetailMenu: View {
    
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
    static var previews: some View {
        StoreDetailMenu()
    }
}
