//
//  CoreDataID.swift
//  AQ_Fetch
//
//  Created by Mando Quintana on 7/1/21.
//
import UIKit
import Foundation
import CoreData

class CoreDataManager {
    private var eventIds: [NSManagedObject]
    
    init() {
        self.eventIds = []
    }
    
    func saveEvent(eventIdToSave: Int){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "EventID",
                                       in: managedContext)!
          
        let eventiD = NSManagedObject(entity: entity, insertInto: managedContext)
        eventiD.setValue(eventIdToSave, forKey: "iD")
        do {
            try managedContext.save()
            eventIds.append(eventiD)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    
    func fetchSavedEvents(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "EventID")
        
          //3
          do {
            self.eventIds = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
    
    func isFavorite(iD: Int) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EventID")
        let filterPredicate = NSPredicate(format: "iD == \(iD)")
        fetchRequest.predicate = filterPredicate
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if results.count != 0 {
                return true
            }
            
        }catch{
            print("Could not fetch. \(error), \(error.localizedDescription)")
        }

        return false
    }
    
    func deleteEvent(iD: Int) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EventID")
        let filterPredicate = NSPredicate(format: "iD == \(iD)")
        fetchRequest.predicate = filterPredicate
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for event in results {
                managedContext.delete(event)
            }
            try managedContext.save()
        }catch{
            print("Could not fetch. \(error), \(error.localizedDescription)")
        }
    }
    
    func getSavedEvents() -> [NSManagedObject] {
        return self.eventIds
    }
}

