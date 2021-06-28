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
        
    }
    
}
