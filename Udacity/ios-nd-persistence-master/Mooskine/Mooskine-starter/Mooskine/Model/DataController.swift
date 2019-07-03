//
//  DataController.swift
//  Mooskine
//
//  Created by Peter Pohlmann on 14.12.18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import CoreData

class DataController{
    let persistenContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext{
        return persistenContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext!
    
    init(modelName: String){
        persistenContainer = NSPersistentContainer(name: modelName)
       
    }
    
    func configureContext(){
        backgroundContext = persistenContainer.newBackgroundContext()
        
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        
    }
    
    func load(completion: (() -> Void)? = nil){
        persistenContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else{
                print("load persistence error")
                return
            }
            self.configureContext()
            //self.autoSave()
            completion?()
        }
    }
}

extension DataController{
    func autoSave(interval: TimeInterval = 3){
        print("autosave")
        guard interval > 0 else{
            print("bad interval")
            return
        }
        
        if viewContext.hasChanges{
            try? viewContext.save()
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSave(interval: interval)
        }
 
    }
}
