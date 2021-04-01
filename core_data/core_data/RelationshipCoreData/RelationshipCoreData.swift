//
//  RelationshipCoreData.swift
//  core_data
//
//  Created by somsak on 30/3/2564 BE.
//

import UIKit
import CoreData

class RelationshipCoreData {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let countryEntity = "CountryRel"
    let cityEntity = "CityRel"
    let countryforKey = "name"
    let cityforKey = "name"
    
    var CountryRelArray: [CountryRel] = []
    var CityRelArray: [CityRel] = []
    
    func saveCountryData(data: String){
        let newCountry = NSEntityDescription.insertNewObject(forEntityName: countryEntity, into: context)
        
        newCountry.setValue(data, forKey: countryforKey)
        
        do {
            try context.save()
            
            print("save success forKey", newCountry.value(forKey: countryforKey) as Any)
        } catch  {
            print(error)
        }
    }
    
    func saveCityData(data: String, relation: CountryRel){
        
        let city = CityRel(context: context)
        city.name = data
        city.origin = relation
        
        do {
            try context.save()
            
            print("save success forKey", city)
        } catch  {
            print(error)
        }
    }
    
    func fetchCountryData() -> [CountryRel]{

        do {
            self.CountryRelArray = try self.context.fetch(CountryRel.fetchRequest())
        } catch  {
            print(error)
        }

        print("self.CRUDArray.count", self.CountryRelArray.count)

        for i in 0..<self.CountryRelArray.count {
            print("self.CountryRelatArray[\(i)].name", self.CountryRelArray[i].name as Any)
        }
        
        return self.CountryRelArray
    }
    
    func fetchCityData(country: String) -> [CityRel]{
        
        do {

            let predicate = NSPredicate(format: "origin.name = '\(country)'")

            let fetchRequest = CityRel.fetchRequest() as NSFetchRequest<CityRel>
            fetchRequest.predicate = predicate
            self.CityRelArray = try self.context.fetch(fetchRequest)
        } catch  {
            print(error)
        }

        print("self.CityRelArray.count", self.CityRelArray.count)

        for i in 0..<self.CityRelArray.count {
            print("self.CityRelArray[\(i)].name", self.CityRelArray[i] as Any)
        }
        
        return self.CityRelArray
    }
    
    func updateCityData(index: Int, data: String){

        do {
            self.CityRelArray = try self.context.fetch(CityRel.fetchRequest())
            self.CityRelArray[index].setValue(data, forKey: cityforKey)

            try context.save()
        } catch  {
            print(error)
        }
    }

    func deleteCityData(data: CityRel){
        do {
            self.context.delete(data)
            print("delete \(data) success")
            try self.context.save()
            print("self.context.fetch(CityRel.fetchRequest()).count", try! self.context.fetch(CityRel.fetchRequest()).count)
        } catch {
            print(error)
        }
    }
}
