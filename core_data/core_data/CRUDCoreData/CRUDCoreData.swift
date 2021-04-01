//
//  CRUDCoreData.swift
//  core_data
//
//  Created by somsak on 29/3/2564 BE.
//

import UIKit
import CoreData

class CRUDCoreData {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let entity = "CRUD"
    let forKey = ["name", "serName"]
    
    var CRUDArray: [CRUD] = []
    
    func saveCRUDData(data: [String]){
        let newCRUD = NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
        
        newCRUD.setValue(data[0], forKey: forKey[0])
        newCRUD.setValue(data[1], forKey: forKey[1])
        
        do {
            try context.save()
            
            for _ in 0..<data.count {
                print("save success forKey[0]", newCRUD.value(forKey: forKey[0]) as Any)
                print("save success forKey[1]", newCRUD.value(forKey: forKey[1]) as Any)
            }
        } catch  {
            print(error)
        }
    }
    
    func fetchCRUDData() -> [CRUD]{
        
        do {
            self.CRUDArray = try self.context.fetch(CRUD.fetchRequest())
        } catch  {
            print(error)
        }
        
        print("self.CRUDArray.count", self.CRUDArray.count)
        
        for i in 0..<self.CRUDArray.count {
            print("self.CRUDArray[\(i)].name", self.CRUDArray[i].name as Any)
            print("self.CRUDArray[\(i)].serName", self.CRUDArray[i].serName as Any)
        }
        
        return self.CRUDArray
    }
    
    func updateCRUDData(index: Int, data: [String]){
        
        do {
            self.CRUDArray = try self.context.fetch(CRUD.fetchRequest())
            
            self.CRUDArray[index].setValue(data[0], forKey: forKey[0])
            self.CRUDArray[index].setValue(data[1], forKey: forKey[1])
            
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    func deleteCRUDData(data: CRUD){
        do {
            self.context.delete(data)
            print("delete \(data) success")
            try self.context.save()
            print("self.context.fetch(CRUD.fetchRequest()).count", try! self.context.fetch(CRUD.fetchRequest()).count)
        } catch {
            print(error)
        }
    }
}

