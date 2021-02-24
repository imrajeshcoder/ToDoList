//
//  TODOMainStoryboardViewController.swift
//  ToDoList
//
//  Created by Vijay on 17/02/21.
//

import UIKit

class TODOMainStoryboardViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    

    @IBOutlet weak var tblOutlettodoDisplay: UITableView!
    var toDoMasterClass:[ToDoMasterClass] = []
    let dbHelper = DBHelperCoreData()
    var dicToDo  = [String:String] ()
    
    
    override func viewDidLoad() {
        tblOutlettodoDisplay.dataSource = self
        tblOutlettodoDisplay.delegate = self
        super.viewDidLoad()
     
        
//        dicToDo = ["todotitle" : "Reading" , "tododscription" : "dfgdf fdfgsdfgsd" , "tododate": "2021-02-18" , "todotime" : "08:00:00"]
//        //dbHelper.insertData(object: dicToDo)
//        toDoMasterClass = dbHelper.readAllData()
//        //print(toDoMasterClass)
//        for item in toDoMasterClass {
//            print(item.todotitle)
//            print(item.todoid)
//        }
        // Do any additional setup after loading the view.
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        
        dicToDo = ["todotitle" : "Reading" , "tododscription" : "dfgdf fdfgsdfgsd" , "tododate": "2021-02-18" , "todotime" : "08:00:00"]
        //dbHelper.insertData(object: dicToDo)
        toDoMasterClass = dbHelper.readAllData()
        tblOutlettodoDisplay.reloadData()
        //print(toDoMasterClass)
        for item in toDoMasterClass {
            print(item.todotitle)
            print(item.todoid)
        }
    }
    
    @IBAction func btnActionAddBtnTouchUp(_ sender: UIButton) {
        var vc = storyboard?.instantiateViewController(identifier: "TODOAddNewToDoViewController") as! TODOAddNewToDoViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func displayDeleteAlert(completion:@escaping (Bool) -> Void){
        let alert = UIAlertController(title: "Delete Alert", message: "Are you Sure Want to Delete This?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { action in
            completion(true)
        })
        
        let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
            completion(false)
        })
        alert.view.tintColor = UIColor(red: 116/255, green: 69/255, blue: 191/255, alpha: 1)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Delete", handler: { (action,view,completionHandler ) in
            //do stuff
            self.displayDeleteAlert { [self] (iSsuccess) in
                if (iSsuccess)
                {
                    self.dbHelper.deleteRecordByTodoId(todoId: toDoMasterClass[indexPath.row].todoid)
                    self.toDoMasterClass.remove(at: indexPath.row)
                    self.tblOutlettodoDisplay.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .fade)
                    self.tblOutlettodoDisplay.reloadData()
                }
                completionHandler(true)
            }
        })
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = UIColor(red: 255/255, green: 52/255, blue: 52/255, alpha: 1)
        var deleteConfiguration : UISwipeActionsConfiguration
        deleteConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return deleteConfiguration
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoMasterClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tblOutlettodoDisplay.dequeueReusableCell(withIdentifier: "TODODisplayTableViewCell", for: indexPath) as! TODODisplayTableViewCell
        cell.lblOutletTodoTitle.text = toDoMasterClass[indexPath.row].todotitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "TODOAddNewToDoViewController")as? TODOAddNewToDoViewController {
//            vc.revExpance?.append(arrDayWiseData[indexPath.section].data[indexPath.row])
            vc.isEditingToDo = true
            vc.intToDoId = toDoMasterClass[indexPath.row].todoid
            vc.strToDoTitle = toDoMasterClass[indexPath.row].todotitle
            vc.strToDoDescription = toDoMasterClass[indexPath.row].tododscription
            vc.strToDoDate = toDoMasterClass[indexPath.row].tododate
            vc.strToDoTime = toDoMasterClass[indexPath.row].todotime
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
