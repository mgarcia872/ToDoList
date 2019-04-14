//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Maria S Garcia on 4/2/19.
//  Copyright © 2019 Maria S Garcia. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController,
ToDoCellDelegate
{
    // vars
    
    
    var todos = [ToDo]()
    
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func completeButtonTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    
    // IBAction's
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
        ToDoViewController
        
        if let todo = sourceViewController.todo {
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath],
                                     with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count,
                                             section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath],
                                     with: .automatic)
            }
        }
        ToDo.saveToDos(todos)
    } // end of prepare, for segue
    
    // override funcs
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let savedToDos = ToDo.loadToDos()
        {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    } // end of viewDidLoad()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todos.count
    } // end of override func tableView, numberOfRowsInSection
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier:
                "ToDoCellIdentifier") as? ToDoCell else {
                    fatalError("Could not dequeue a cell")
        }
        cell.delegate = self

        let todo = todos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        return cell
        
    } // end of override func tableView, cellForRowAt
    
    override func tableView(_ tableView: UITableView, canEditRowAt
        indexPath: IndexPath) -> Bool
    {
        return true
    } // end of override func tableView, canEditRowAt
    
    override func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:
        IndexPath)
    {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(todos)
        }
    } // end of override func tableView, commit
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    { // pushes the cell from the To-Do List to the static table
        
        if segue.identifier == "showDetails" {
            let todoViewController = segue.destination
                as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
    } // end of prepare, for segue
    
}
