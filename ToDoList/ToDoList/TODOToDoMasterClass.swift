//
//  TODOToDoMasterClass.swift
//  ToDoList
//
//  Created by Vijay on 17/02/21.
//

import Foundation

class ToDoMasterClass {
    
    var todoid : Int = 0
    var todotitle : String = ""
    var tododscription : String = ""
    var tododate : String = ""
    var todotime : String = ""
    
    init(todoid:Int, todotitle: String, tododscription: String, tododate: String, todotime: String) {
        self.todoid = todoid
        self.todotitle = todotitle
        self.tododscription = tododscription
        self.tododate = tododate
        self.todotime = todotime
    }
}
