//
//  Store+Extension.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/01.
//

import CoreData
import SwiftUI

extension Store {
    
    static func create(in managedObjectContext: NSManagedObjectContext, name: String) {
        
        let newStore = self.init(context: managedObjectContext)
        newStore.name = name
        newStore.id = UUID().uuidString
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
}
