//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Maria S Garcia on 4/2/19.
//  Copyright © 2019 Maria S Garcia. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate
{
    
    var todos = [ToDo]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedToDos = ToDo.loadToDos()
        {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        } // end of if-else
    } // end of viewDidLoad
    
    // MARK: - Table View Data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    } // end of numberOfSections
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todos.count
    } // end of numberOfRowsInSection
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else
        {
            fatalError("Could not dequeue a cell.")
        } // end of guard cell
        
        let todo = todos[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        cell.delegate = self
        
        return cell
    } // end of cellForRowAt
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    } // end of canEditRowAt
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(todos)
        } // end of if-statement
    } // end of comit editingStyle
    
    // MARK: - ToDo Cell Delegate
    
    func checkMarkTapped(_ sender: ToDoCell)
    {
        if let indexPath = tableView.indexPath(for: sender)
        {
            var todo = todos[indexPath.row]
            
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        } // end of if-statement
    } // end of checkMarkTapped
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "saveUnwind" else { return }
        
        let sourceViewController = segue.source as! ToDoViewController
        
        if let todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            } // end of if-else
        } // end of if-let
        
        ToDo.saveToDos(todos)
    } // end of unwindToToDoList
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showDetails"
        {
            let todoViewController = segue.destination as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            
            todoViewController.todo = selectedTodo
        } // end of if-statement
    } // end of prepare for Segue
} // end of ToDoTableViewController
