//
//  Category+Extension.swift
//  osake
//
//  Created by 高橋優人 on 2021/06/28.
//

import CoreData
import SwiftUI

extension Category {
    
    static func create(in managedObjectContext: NSManagedObjectContext, name: String, kind: kind) {
        
        let category = self.init(context: managedObjectContext)
        category.name = name
        category.kind = kind.rawValue
        category.id = UUID().uuidString
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
    enum kind: Int16 {
        
        case liquor //醸造酒
        case spirit //蒸留酒
        
        func toString() -> String {
            switch self {
            case .liquor:
                return "醸造酒"
            case .spirit:
                return "蒸留酒"
            }
        }
    }
    
}
