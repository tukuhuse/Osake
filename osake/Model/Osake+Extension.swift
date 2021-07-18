//
//  Osake+Extension.swift
//  osake
//
//  Created by 高橋優人 on 2021/06/28.
//

import CoreData
import SwiftUI

extension Osake {
    
    static func create(in managedObjectContext: NSManagedObjectContext, name: String, kind_id: Int16) {
        
        let osake = self.init(context: managedObjectContext)
        osake.id = UUID().uuidString
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
    @nonobjc public class func fetchRequest2() -> NSFetchRequest<Osake> {
        return NSFetchRequest<Osake>(entityName: "Osake")
    }
    
    
    
    
}
