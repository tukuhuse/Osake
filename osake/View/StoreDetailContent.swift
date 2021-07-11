//
//  StoreDetailContent.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/04.
//
import MapKit
import SwiftUI

struct StoreDetailContent: View {
    @ObservedObject var store: Store
    @ObservedObject var keyboard = KeyboardObserver()
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var location = LocationViewModel()
    @State private var showingsheet = false

    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("店名")) {
                    TextField("店名を入力", text: Binding($store.name, "new Store"))
                }
                Section(header: Text("食べ物のコスパ")) {
                    Slider(value: $store.foodcostperformance, in: 0...5, step: 0.5)
                    Text("\(store.foodcostperformance)")
                }
                Section(header: Text("お酒のコスパ")) {
                    Slider(value: $store.drinkcostperformance, in: 0...5, step: 0.5)
                    Text("\(store.drinkcostperformance)")
                }
                Section(header: Text("店の場所")) {
                    HStack {
                        Button(action: {
                            self.location.start()
                            store.latitude = location.lastknownlocation!.latitude
                            store.longitude = location.lastknownlocation!.longitude
                            
                            self.save()
                        }) {
                            Text("現在地を登録")
                        }
                        Spacer()
                        Button(action: {
                            self.showingsheet.toggle()
                        }) {
                            Text("地図上で選択").foregroundColor(.red)
                        }
                        .sheet(isPresented: $showingsheet) {
                            StoreMap()
                        }
                    }
                    Text("登録座標")
                    Text("緯度:\(store.latitude)")
                    Text("経度:\(store.longitude)")
                }
                Section(header: Text("コメント")) {
                    TextEditor(text: Binding($store.comment, ""))
                }
            }
            .navigationTitle("お店の情報")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.save()
                    }, label: {
                        Text("保存")
                    })
                }
            })
        }.onAppear{
            self.keyboard.startObserve()
        }.onDisappear{
            self.keyboard.stopObserve()
        }.padding(.bottom, keyboard.keyboardHeight)
    }
}

struct StoreDetailContent_Previews: PreviewProvider {
    
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        let newStore = Store(context: viewContext)
        return StoreDetailContent(store: newStore).environment(\.managedObjectContext, viewContext)
    }
}
