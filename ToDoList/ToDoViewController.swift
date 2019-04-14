//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by MariaSGarcia on 4/6/19.
//  Copyright © 2019 MariaSGarcia. All rights reserved.

import UIKit

class ToDoViewController : UITableViewController
{
    
    // vars
    
    
    var isEndDatePickerHidden = true
    var todo: ToDo?
    
    
    // IBOutlets
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    // IBActions
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker)
    {
        updateDueDateLabel(date: dueDatePickerView.date)
    } // end of datePickerChanged
    
    @IBAction func textEditingChanged(_ sender: UITextField)
    {
        updateSaveButtonState()
    } // end of textEditingChanged
    
    @IBAction func returnPressed(_ sender: UITextField)
    {
        titleTextField.resignFirstResponder()
    } // end of returnPressed
    @IBAction func isCompleteButtonTapped(_ sender: UIButton)
    {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    
    // func list
    
    
    func updateSaveButtonState()
    {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    } // end of updateSaveButtonState
    
    func updateDueDateLabel(date: Date)
    {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    } // end of dueDateLabel
    
    
    // override func list
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date =
                Date().addingTimeInterval(24*60*60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
        
    } // end of viewDidLoad
    
    override func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat
    { // modifies the cell size
    
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case [1,0]: //Due Date Cell
            return isEndDatePickerHidden ? normalCellHeight :
            largeCellHeight
            
        case [2,0]: //Notes Cell
            return largeCellHeight
            
        default: return normalCellHeight
        }
    } // end of tableView, heightForRowAt
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath)
    { // shows the date picker when date label selected
        
        switch (indexPath)
        {
        case [1,0]:
            isEndDatePickerHidden = !isEndDatePickerHidden
            
            dueDateLabel.textColor =
                isEndDatePickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        }
    } // end of tableView, didSelecRowAt
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?)
    { // sending data to the To-Do List
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate:
            dueDate, notes: notes)
    } // end of prepare, for segue

}
