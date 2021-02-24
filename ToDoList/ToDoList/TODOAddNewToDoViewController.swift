//
//  TODOAddNewToDoViewController.swift
//  ToDoList
//
//  Created by Vijay on 17/02/21.
//

import UIKit
import UserNotifications

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
    var datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    var datepickerTimeSelect = UIDatePicker()
    var dateFormatter = DateFormatter()
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
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        txtOutletToDoDate.inputView = datePicker
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())

       
        datepickerTimeSelect.datePickerMode = .time
        datepickerTimeSelect.preferredDatePickerStyle = .wheels
        
        txtOutletToDoTime.inputView = datepickerTimeSelect

        var item = [UIBarButtonItem]()
        item.append(UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelDate)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        item.append(space)
        
        item.append(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDate)))
        toolBar.items = item
        toolBar.sizeToFit()
        txtOutletToDoDate.inputAccessoryView = toolBar
        txtOutletToDoTime.inputAccessoryView = toolBar
    }
    
    
    
    
    
    @objc func cancelDate()
    {
        
        if txtOutletToDoDate.isFirstResponder{
            txtOutletToDoDate.resignFirstResponder()
        }else{
            txtOutletToDoTime.resignFirstResponder()
        }
               
    }
    
    @objc func doneDate()
    {
       
        if txtOutletToDoDate.isFirstResponder{
            txtOutletToDoDate.resignFirstResponder()
            
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.dateFormat = "YYYY-MM-dd"
            txtOutletToDoDate.text = "\(dateFormatter.string(from: datePicker.date))"
        }else{
            txtOutletToDoTime.text = ""
            txtOutletToDoTime.resignFirstResponder()
            var dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.dateFormat = "HH:mm"
            txtOutletToDoTime.text = "\(dateFormatter.string(from: datepickerTimeSelect.date))"
        }
        
        
    }
    func textViewDidChange(_ textView: UITextView) {
        if txtOutletToDoDiscription.textColor == UIColor.lightGray {
            txtOutletToDoDiscription.text = nil
            txtOutletToDoDiscription.textColor = UIColor.black
        }
    }
     
    @IBAction func btnActionAddOrSaveTouchUp(_ sender: UIButton) {
        dicToDo = ["todotitle" : "\(txtoutletToDoTitle.text!)" , "tododscription" : "\(txtOutletToDoDiscription.text!)" , "tododate": "\(txtOutletToDoDate.text!)" , "todotime" : "\(txtOutletToDoTime.text!)"]
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
//        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: datepickerTimeSelect.date)
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: dateFormatter.date(from: txtOutletToDoDate.text!)!)
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "HH:mm"
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: dateFormatter.date(from: txtOutletToDoTime.text!)!)
        scheduleLocalNotification(dateComponent: dateComponents, timeComponent: timeComponents, notificationTitle: txtoutletToDoTitle.text!, notificationBody: txtOutletToDoDiscription.text!)
       
        
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

    func scheduleLocalNotification(dateComponent: DateComponents, timeComponent: DateComponents, notificationTitle: String, notificationBody: String)  {
        
        let notificationCenter = UNUserNotificationCenter.current()

        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = notificationTitle
        notificationContent.body = notificationBody
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.userInfo = ["customData": "fizzbuzz"]
        notificationContent.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.day = dateComponent.day
        dateComponents.month = dateComponent.month
        dateComponents.year = dateComponent.year
        dateComponents.hour = timeComponent.hour
        dateComponents.minute = timeComponent.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        notificationCenter.add(request)
    }
    

}
