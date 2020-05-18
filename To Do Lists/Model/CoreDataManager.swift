//
//  CoreDataManager.swift
//  To Do Lists
//
//  Created by Amir Daliri on 5/17/20.
//  Copyright © 2020 Amir Daliri. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    //Mark: - Properties
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "To_Do_Lists")
        container.loadPersistentStores(completionHandler: { (storedescription, err) in
            if let err = err {
                print("loading of stores faild, error: \(err)")
            }
        })
        return container
    }()
    
    // - adding new objects to container method
    func createList(title: String, description: String?) -> List {
        let context = persistentContainer.viewContext
        let newList = NSEntityDescription.insertNewObject(forEntityName: "List", into: context) as! List
        newList.title = title
        if let existedDescription = description {
            newList.descriptionText = existedDescription
        }
        newList.done = false
        do {
            try context.save()
            return newList
        } catch let err {
            print("failed to save New list:", err)
            return newList
        }
    }
    
    // - fetching from container method
    func fetchLists() -> [List] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<List>(entityName: "List")
        do {
            let lists = try context.fetch(fetchRequest)
            return lists
        } catch let err{
            print("failed to fetch lists", err)
            return []
        }
    }
    
    // - updating lists method
    
    func updateList(list: List, description: String, isDone: Bool) {
        let context = persistentContainer.viewContext
        list.descriptionText = description
        list.done = isDone
        do {
            try context.save()
        } catch let err {
            print("error updating list", err)
        }
    }
    
    
}

