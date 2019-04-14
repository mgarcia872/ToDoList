//
//  ToDo.swift
//  ToDoList
//
//  Created by Maria Garcia on 4/2/19.
//  Copyright © 2019 Maria Garcia. All rights reserved.
//

import UIKit

struct ToDo : Codable // To pesist data
{
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let DocumentsDirectory =
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask).first!
    static let ArchiveURL =
        DocumentsDirectory.appendingPathComponent("todos")
            .appendingPathExtension("plist")
    
    static func loadToDos() -> [ToDo]?
    { // Use a PropertyListDecoder and the methods on Data that you learned in a previous lesson to unarchive the data and return it
        guard let codedToDos = try? Data(contentsOf: ArchiveURL)
            else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self,
                                               from: codedToDos)
    }// end of func loadToDos()
    
    static func saveToDos(_ todos: [ToDo])
    { //Write a static method that uses a PropertyListEncoder to encode a [ToDo] collection and then uses the write(to:options:) method on Data to store it in the Documents directory
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL,
                               options: .noFileProtection)
        
    }
    
    static func loadSampleToDos() -> [ToDo]
    {
        let todo1 = ToDo(title: "To-Do One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "To-Do Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "To-Do Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    } // end of func loadSampleToDos()
    
    static let dueDateFormatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }() // end of dueDateFormatter
    
}

