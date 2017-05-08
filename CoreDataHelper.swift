//
//  CoreDataHelper.swift
//  FitHelper
//
//  Created by артем on 03.05.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CoreDataHelper: NSObject {
    class var instance: CoreDataHelper{
        struct helper{
            static let instance = CoreDataHelper()
        }
        return helper.instance
    }
    let coordinator:NSPersistentStoreCoordinator
    let model:NSManagedObjectModel
    let context:NSManagedObjectContext
    private override init(){
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        model = NSManagedObjectModel(contentsOf: modelURL)!
        let fileManager = FileManager.default
        let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            .last! as NSURL
        let storeURL = docsURL.appendingPathComponent("base.sqlite")
        coordinator = NSPersistentStoreCoordinator(managedObjectModel:model)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch let error {
            print("coordinator error occured \(error.localizedDescription)")
        }
        context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        super.init()
    }
    
    func allObjectsFromContext() -> [NSManagedObject]{
        return Array(context.registeredObjects)
    }
    
    func save(){
        do {
            try context.save()
        } catch let error {
            print("context error occured \(error.localizedDescription)")
        }
    }
}
