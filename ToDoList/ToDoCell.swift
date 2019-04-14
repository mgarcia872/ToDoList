//
//  ToDoCell.swift
//  ToDoList
//
//  Created by student17 on 4/13/19.
//  Copyright © 2019 student17. All rights reserved.
//

import UIKit

@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell
{
    var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBAction func completeButtonTapped(_ sender: UIButton)
    {
        delegate?.checkmarkTapped(sender: self)
        
    }
    
} // end of class ToDoCell
