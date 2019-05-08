//
//  ToDoCell.swift
//  ToDoList
//
//  Created by student17 on 4/13/19.
//  Copyright © 2019 student17. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate
{
    func checkMarkTapped(_ sender: ToDoCell)
} // end of protocol

class ToDoCell: UITableViewCell
{
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: ToDoCellDelegate?
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton)
    {
        delegate?.checkMarkTapped(self)
    } // end of isCompleteButtonTapped

} // end of ToDoCell class
