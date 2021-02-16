//
//  DBHelper.swift
//  ToDoList
//
//  Created by Vijay on 16/02/21.
//

import Foundation
import CoreData
import UIKit

class DBHelperCoreData {
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context:NSManagedObjectContext!
    
    
    func insertData(object: [String: String])  {
        let managedContext = appDelegate.persistentContainer.viewContext
        let toDoEntity = NSEntityDescription.entity(forEntityName: "TodoMaster", in: managedContext)!
        let toDo = NSManagedObject(entity: toDoEntity, insertInto: managedContext)
    }
    
}
