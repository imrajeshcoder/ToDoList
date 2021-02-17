//
//  TODODisplayTableViewCell.swift
//  ToDoList
//
//  Created by Vijay on 17/02/21.
//

import UIKit

class TODODisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOutletTodoTitle: UILabel!
    var toDoMasterClass:[ToDoMasterClass] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
