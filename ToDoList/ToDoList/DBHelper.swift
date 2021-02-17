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
    var toDoMasterClass:[ToDoMasterClass] = []
    
    
    func fetchMaxTodoId() -> Int {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return 0 }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todomaster")

        fetchRequest.fetchLimit = 1
        let sortDescriptor = NSSortDescriptor(key: "todoid", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let todo = try managedContext.fetch(fetchRequest) as! [Todomaster]
            if todo.count>0{
                let max = todo.first!
                return max.value(forKey: "todoid")! as! Int
            }else{
                return 0
            }
            
            //print(max.value(forKey: "todoid")!)
           
        } catch _ {

        }
        return 0
    }
    
    
    
    func insertData(object: [String:String]){
        
        var todoId = fetchMaxTodoId()
        todoId += 1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let toDoEntity = NSEntityDescription.entity(forEntityName: "Todomaster", in: managedContext)
        let toDo = NSManagedObject(entity: toDoEntity! , insertInto: managedContext)
        toDo.setValue(todoId, forKey: "todoid")
        toDo.setValue(object["todotitle"], forKey: "todotitle")
        toDo.setValue(object["tododscription"], forKey: "tododscription")
        toDo.setValue(object["tododate"], forKey: "tododate")
        toDo.setValue(object["todotime"], forKey: "todotime")
        
        do
        {
            try managedContext.save()
        } catch let error as NSError{
            print("Could Not Save Data. \(error), \(error.userInfo)")
        }
    }
    
    func readAllData() -> [ToDoMasterClass]  {
         toDoMasterClass = []
        var dicTodoObject = [String:String]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return toDoMasterClass
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todomaster")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "todotitle") as! String)
//                print(data.value(forKey: "tododscription") as! String)
                toDoMasterClass.append( ToDoMasterClass(todoid:data.value(forKey: "todoid") as! Int, todotitle: data.value(forKey: "todotitle") as! String, tododscription: data.value(forKey: "tododscription") as! String, tododate: data.value(forKey: "tododate") as! String, todotime: data.value(forKey: "todotime") as! String))
            }
            
        } catch  {
            print("Faild Reading Data.")
        }
        return toDoMasterClass
    }
    
    func updateRecordByTodoId(todoId: Int, object: [String:String]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todomaster")
        fetchRequest.predicate = NSPredicate(format: "todoid = %@", "\(todoId)")
        do
        {
            let test = try manageContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject

            objectUpdate.setValue(object["todotitle"], forKey: "todotitle")
            objectUpdate.setValue(object["tododscription"], forKey: "tododscription")
            objectUpdate.setValue(object["tododate"], forKey: "tododate")
            objectUpdate.setValue(object["todotime"], forKey: "todotime")
            do {
                try manageContext.save()
            } catch  {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
        
    }
    
    func deleteRecordByTodoId(todoId: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todomaster")
        fetchRequest.predicate = NSPredicate(format: "todoid =%@", "\(todoId)")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do
            {
                try managedContext.save()
            } catch
            {
                print("Error In Deleting Record", error)
            }
            
        } catch
        {
            print("Error: " , error)
        }
    }
    
}
