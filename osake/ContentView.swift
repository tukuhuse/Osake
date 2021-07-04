//
//  ContentView.swift
//  osake
//
//  Created by 高橋優人 on 2021/06/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: CategorySelect(kind: .liquor),
                    label: {
                        Text("お酒の種類を選択")
                    })
                Spacer()
                NavigationLink(
                    destination: StoreSelect(),
                    label: {
                        Text("お店を選択")
                    })
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
