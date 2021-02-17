//
//  TODOAddNewToDoViewController.swift
//  ToDoList
//
//  Created by Vijay on 17/02/21.
//

import UIKit

class TODOAddNewToDoViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var btnOutletInsertOrSave: UIButton!
    @IBOutlet weak var txtoutletToDoTitle: UITextField!
    @IBOutlet weak var txtOutletToDoDiscription: UITextView!
    @IBOutlet weak var txtOutletToDoDate: UITextField!
    @IBOutlet weak var txtOutletToDoTime: UITextField!
    var strToDoTitle = ""
    var strToDoDescription = ""
    var strToDoDate = ""
    var strToDoTime = ""
    var isEditingToDo = false
    var intToDoId : Int = 0
    let dbHelper = DBHelperCoreData()
    var dicToDo  = [String:String] ()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtoutletToDoTitle.text = strToDoTitle
        txtOutletToDoDiscription.text = strToDoDescription
        txtOutletToDoDate.text = strToDoDate
        txtOutletToDoTime.text = strToDoTime
        if(isEditingToDo)
        {
            print("Todo Edit")
            btnOutletInsertOrSave.setTitle("Save", for: .normal)
        }
        else
        {
            print("New ToDO ADD")
            txtOutletToDoDiscription.text = "Enter ToDo Discription"
            txtOutletToDoDiscription.textColor = UIColor.lightGray
            btnOutletInsertOrSave.setTitle("Add", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }
    func textViewDidChange(_ textView: UITextView) {
        if txtOutletToDoDiscription.textColor == UIColor.lightGray {
            txtOutletToDoDiscription.text = nil
            txtOutletToDoDiscription.textColor = UIColor.black
        }
    }
     
    @IBAction func btnActionAddOrSaveTouchUp(_ sender: UIButton) {
       // intToDoId = dicToDo["todoid"] as! Int
        dicToDo = ["todotitle" : "\(txtoutletToDoTitle.text!)" , "tododscription" : "\(txtOutletToDoDiscription.text!)" , "tododate": "\(txtOutletToDoDate.text!)" , "todotime" : "\(txtOutletToDoTime.text!)"]
        if isEditingToDo
        {
            dbHelper.updateRecordByTodoId(todoId: intToDoId, object: dicToDo)
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            
            dbHelper.insertData(object: dicToDo)
            self.navigationController?.popViewController(animated: true)
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
