//
//  DefaultCoreData.swift
//  core_data
//
//  Created by somsak on 29/3/2564 BE.
//

import UIKit
import CoreData

class DefaultCoreData {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let entity = "DefaultData"
    let forKey = "text"
    
    var defaultArray: [DefaultData] = []
    
    func saveDefaultData(data: String){
        let newText = NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
        
        newText.setValue(data, forKey: forKey)
        
        do {
            try context.save()
            
            print("save success", newText.value(forKey: forKey) as Any)
        } catch  {
            print(error)
        }
    }
    
    func fetchDefaultData() -> [DefaultData]{
        
        do {
            self.defaultArray = try self.context.fetch(DefaultData.fetchRequest())
        } catch  {
            print(error)
        }
        
        print("self.defaultArray.count", self.defaultArray.count)
        print("self.defaultArray.last?.text", self.defaultArray.last?.text as Any)
        
        return self.defaultArray
    }
    
    func deleteDefaultData(){
        do {
            let objects = try self.context.fetch(DefaultData.fetchRequest())
            for object in objects {
                self.context.delete(object as! NSManagedObject)
                print("delete success", object)
            }
            try self.context.save()
            print("self.context.fetch(Default.fetchRequest()).count", try! self.context.fetch(DefaultData.fetchRequest()).count)
        } catch {
            print(error)
        }
    }
}
